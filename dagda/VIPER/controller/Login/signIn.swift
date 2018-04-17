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



class SignIn : UIViewController{
    
    var cellView : UIView!
    let signUp = UIButton(type: .custom)
    let signIn = UIButton(type: .custom)
    let viewTitle = labelWithTitle("Dagda", size: 50)
    let dictionarySignUp = ["Mot de passe": textViewWith(), "Email":textViewWith()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setTitle()
        setCellview()
        setButtonUp()
        setView()
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
        let top : CGFloat = -3
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
        cellView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 5).isActive = true
    }
    
    func setButtonUp(){
        signUp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUp)
        signUp.addTarget(self, action: #selector (SignIn.signUpAction(_:)), for: .touchDown)
        signUp.setTitle("Créer compte", for: .normal)
        signUp.titleLabel?.font = fontWith(16)
        signUp.heightAnchor.constraint(equalToConstant: 30).isActive = true
        signUp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signUp.centerXAnchor.constraint(equalTo: cellView.centerXAnchor, constant: -60).isActive = true
        signUp.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15).isActive = true
        
        
        // sign in
        signIn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signIn)
      //  signIn.addTarget(self, action: #selector (SignIn.signIn(_:)), for: .touchDown)
        signIn.setTitle("Connecter", for: .normal)
        signIn.titleLabel?.font = fontWith(16)
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
                createAlert(title:"Connection", message: "Veuiller renseigner votre " + name + ".")
                return false
            }
        }
        return true
    }
    
    
    @objc  func signIn(_ sender: Any){
        print ("Sign In")
        if checkField() {
            guard let email = dictionarySignUp["Email"]?.text , let password = dictionarySignUp["Mot de passe"]?.text else {
                return
            }
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
                if let err = error {
                    print(err.localizedDescription)
                    self.createAlert(title: "Connection", message: err.localizedDescription)
                } else {
                    print ("Connected")
                    let ref = Database.database().reference().child("users/Patient")
                    let refUpdate = ref.childByAutoId()
                    let value = ["Nom":"Karim", "prenom":"Dd"]
                    refUpdate.updateChildValues(value)
                    let controller = MemberController()
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            })
        }
    }
    
    func setView(){
        var top : CGFloat = 30
        let leading : CGFloat = 20
        let height : CGFloat = 30
        let width : CGFloat = 120
        for (name, input) in dictionarySignUp{
            input.layer.cornerRadius = 3
            if name == "Mot de passe" {
                input.isSecureTextEntry = true
            }
            let label = labelWithTitle(name, .white)
            label.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(label)
            label.heightAnchor.constraint(equalToConstant: height).isActive = true
            label.widthAnchor.constraint(equalToConstant: width).isActive = true
            label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: top).isActive = true
            label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
            input.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(input)
            input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
            input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
            input.heightAnchor.constraint(equalToConstant: height).isActive = true
            input.widthAnchor.constraint(equalToConstant: width + 20).isActive = true
            top += 40
            
        }
    }
}
