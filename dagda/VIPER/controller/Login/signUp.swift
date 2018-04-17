//
//  signUp.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase


class SignUp  : UIViewController {
    
    var cellView : UIView!
    let signUp = UIButton(type: .custom)
    let viewTitle = labelWithTitle("Joy", size: 50)
    let dictionarySignUp = ["Nom":textViewWith(), "Prenom":textViewWith(), "Mot de passe": textViewWith(), "Email":textViewWith(), "Confirmation":textViewWith()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setTitle()
        setCellview()
        setButtonUp()
        setView()
    }
    
    func setUp(){
        view = GradientView(frame: UIScreen.main.bounds)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = false
        navigationItem.title = "Register"
    }
    
    func setTitle (){
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewTitle.widthAnchor.constraint(equalToConstant: 120).isActive = true
        viewTitle.centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor).isActive = true
    }
    
    func setCellview(){
        cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellView)
        cellView.layer.cornerRadius = 17
        cellView.backgroundColor = cellBackground
        cellView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        cellView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 5).isActive = true
    }
    
    func setButtonUp(){
        signUp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUp)
       // signUp.addTarget(self, action: #selector (SignUp.signUpAction(_:)), for: .touchDown)
        signUp.setTitle("Enregistrer", for: .normal)
        signUp.titleLabel?.font = fontWith(18)
        signUp.heightAnchor.constraint(equalToConstant: 30).isActive = true
        signUp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signUp.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        signUp.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15).isActive = true
    }
    
    func checkField() -> Bool{
        for (name, element) in dictionarySignUp {
            if element.text == ""{
              createAlert(title:"Enregistrer", message: "Veuiller renseigner votre " + name + ".")
                return false
            }
        }
        return true
    }
    
    @objc func signUpAction(_ sender: Any){
        print ("Sign Up ")
        if checkField() {
            guard let email = dictionarySignUp["Email"]?.text , let password = dictionarySignUp["Password"]?.text, let name = dictionarySignUp["Nom"]?.text, let firstname = dictionarySignUp["Prenom"]?.text else {
                return
            }
            if (password == dictionarySignUp["Confirmation"]?.text!) {
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let err = error {
                        print(err.localizedDescription)
                        self.createAlert(title: "Enregistrer", message: err.localizedDescription)
                    } else {
                        let ref = Database.database().reference(fromURL:"https://dagda-9f511.firebaseio.com/")
                        let userRef = ref.child("users")
                        let values = ["Nom":name, "Prenom":firstname, "password":password,"Email":email]
                        userRef.updateChildValues(values)
                        let controller = MemberController()
                        self.navigationController?.pushViewController(controller, animated: true)
                    }}
                )

            }
        }
    }
    
    func setView(){
        let leading : CGFloat = 20
        let height : CGFloat = 30
        let width : CGFloat = 120
        let offset : CGFloat = 25
        for (name, input) in dictionarySignUp{
            input.layer.cornerRadius = 3
            
            switch name {
            case "Nom" :
                let label = labelWithTitle(name, .white)
                label.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(label)
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 30).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
                input.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(input)
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                input.heightAnchor.constraint(equalToConstant: height).isActive = true
                input.widthAnchor.constraint(equalToConstant: width + offset).isActive = true
                break
            case "Prenom":
                let label = labelWithTitle(name, .white)
                label.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(label)
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 70).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
                input.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(input)
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                input.heightAnchor.constraint(equalToConstant: height).isActive = true
                input.widthAnchor.constraint(equalToConstant: width + offset).isActive = true
                break
            case "Email":
                let label = labelWithTitle(name, .white)
                label.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(label)
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 110).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
                input.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(input)
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                input.heightAnchor.constraint(equalToConstant: height).isActive = true
                input.widthAnchor.constraint(equalToConstant: width + offset).isActive = true
                break
            case "Mot de passe":
                let label = labelWithTitle(name, .white)
                label.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(label)
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 150).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
                input.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(input)
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                input.heightAnchor.constraint(equalToConstant: height).isActive = true
                input.widthAnchor.constraint(equalToConstant: width + offset).isActive = true
                break
            case "Confirmation":
                let label = labelWithTitle(name, .white)
                label.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(label)
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 190).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
                input.translatesAutoresizingMaskIntoConstraints = false
                cellView.addSubview(input)
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                input.heightAnchor.constraint(equalToConstant: height).isActive = true
                input.widthAnchor.constraint(equalToConstant: width + offset).isActive = true
                break
            default:
                break
            }
        }
    }
    
}
