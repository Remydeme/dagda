//
//  signIn.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase



class SignIn : UIViewController, UITextViewDelegate{
    
    var cellView : UIView!
    let signUp = UIButton(type: .custom)
    let signIn = UIButton(type: .custom)
    let viewTitle = labelWithTitle("Dagda", size: 50)
    let dictionarySignUp = ["Password": textViewWith(), "Email":textViewWith()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setTitle()
        setCellview()
        setButtonUp()
        setView()
        //API.instance.fetchDescriptionNotConfirmed()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Sign In"
    }
    
    func setUp(){
        view = GradientView(frame: UIScreen.main.bounds)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setTitle (){
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        viewTitle.centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor).isActive = true
    }
    
    func setCellview(){
        cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellView)
        cellView.layer.cornerRadius = 17
        cellView.backgroundColor = cellBackground
        cellView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 5).isActive = true
    }
    
    func setButtonUp(){
        signUp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUp)
        signUp.addTarget(self, action: #selector (SignIn.signUpAction(_:)), for: .touchDown)
        signUp.setTitle("Singn Up", for: .normal)
        signUp.backgroundColor = .black
        signUp.layer.cornerRadius = 17
        signUp.titleLabel?.font = fontWith(16)
        signUp.heightAnchor.constraint(equalToConstant: 30).isActive = true
        signUp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signUp.centerXAnchor.constraint(equalTo: cellView.centerXAnchor, constant: -60).isActive = true
        signUp.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15).isActive = true
        
        
        // sign in
        signIn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signIn)
        signIn.addTarget(self, action: #selector (SignIn.signIn(_:)), for: .touchDown)
        signIn.setTitle("Sign In", for: .normal)
        signIn.titleLabel?.font = fontWith(16)
        signIn.backgroundColor = .black
        signIn.layer.cornerRadius = 17
        signIn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        signIn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signIn.centerXAnchor.constraint(equalTo: cellView.centerXAnchor, constant: 70).isActive = true
        signIn.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15).isActive = true
        
    }
    
    
    
    @objc func signUpAction(_ sender: Any){
        print("Register")
        
        let controller = SignUp()
        navigationController?.pushViewController(controller, animated: true)
    }
    
 
    func checkField() -> Bool{
        for (name, element) in dictionarySignUp {
            if element.text == ""{
                createAlert(title:"Connection", message: "Please fill the " + name + " field.")
                return false
            }
        }
        return true
    }
    
    
    @objc  func signIn(_ sender: Any){
        if checkField() {
            guard let email = dictionarySignUp["Email"]?.text , let password = dictionarySignUp["Password"]?.text else {
                return
            }
            print(password)
            print(email)
            if !(User.instance.connected) {
                Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
                    if let err = error {
                        print(err.localizedDescription)
                        self.createAlert(title: "Ok", message: "Bad password or email please try again.")
                    }
                    else {
                        User.instance.connect()
                        User.instance.configure(name: (user?.email)!, id: (user?.uid)!, note : "Nan")
                        let layout = UICollectionViewFlowLayout()
                        let controller = MemberController(collectionViewLayout: layout)
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                })
            }
        }
    }
    
    func setView(){
        var top : CGFloat = 30
        let leading : CGFloat = 20
        let height : CGFloat = 30
        for (name, input) in dictionarySignUp{
            input.layer.cornerRadius = 3
            if name == "Mot de passe" {
                input.isSecureTextEntry = true
            }
            let label = labelWithTitle(name, .white)
            label.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(label)
            label.heightAnchor.constraint(equalToConstant: height).isActive = true
            label.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.3).isActive = true
            label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: top).isActive = true
            label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
            label.textColor = .black 
            input.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(input)
            input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
            input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
            input.heightAnchor.constraint(equalToConstant: height).isActive = true
            input.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.5).isActive = true
            input.textColor = .black
            input.delegate = self
            top += 40
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}












