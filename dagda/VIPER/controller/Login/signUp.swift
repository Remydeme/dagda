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


protocol SignUpControllerInput {
    func hasBeenAdded()
    func hasNotBeenAdded(error: String?)
    func adminAccountCreated()
    func failedAccountCreation()
}

protocol SignUpControllerOutput {
    func addUser(formular: [String:String])
    func createAccount(email: String, password: String)
}

class SignUp  : UIViewController {
    
    var interactor : SignUpControllerOutput!
    
    var cellView : UIView!
    let signUp = UIButton(type: .custom)
    let viewTitle = labelWithTitle("Dagda", size: 50)
    let dictionarySignUp = ["Family name":textViewWith(), "Firstname":textViewWith(), "Password": textViewWith(), "Email":textViewWith(), "Confirmation":textViewWith()]
    
    
    var formularValues = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setTitle()
        setCellview()
        setButtonUp()
        setView()
        SignUpConfigurer.instance.configure(controller: self)
    }
    
    func setUp(){
        view = GradientView(frame: UIScreen.main.bounds)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .always
        
        // add gesture to hide keyboard on touch
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector (hideKeyBoard(_:)))
        view.addGestureRecognizer(gesture)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Optima", size: 20)!]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = false
        navigationItem.title = "Register"
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = false 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = true 
    }
    
    func setTitle (){
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTitle)
        viewTitle.topAnchor.constraintEqualToSystemSpacingBelow(view.topAnchor, multiplier: 0.2).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        viewTitle.centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor).isActive = true
    }
    
    func setCellview(){
        cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellView)
        cellView.layer.cornerRadius = 17
        cellView.backgroundColor = .white
        cellView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 5).isActive = true
    }
    
    func setButtonUp(){
        signUp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUp)
        signUp.addTarget(self, action: #selector (SignUp.signUpAction(_:)), for: .touchDown)
        signUp.setTitle("save", for: .normal)
        signUp.backgroundColor = .black
        signUp.layer.cornerRadius = 17 
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
        print ("Sign Up in")
        if checkField() {
            guard let email = dictionarySignUp["Email"]?.text , let password = dictionarySignUp["Password"]?.text, let name = dictionarySignUp["Family name"]?.text, let firstname = dictionarySignUp["Firstname"]?.text else {
                print ("Error when trying getting information")
                return
            }
            
            if (password == dictionarySignUp["Confirmation"]?.text!) {
                formularValues["email"] = email
                formularValues["password"] = password
                formularValues["firstname"] = firstname
                formularValues["family name"] = name
                interactor.createAccount(email: email, password: password)
            } else {
                createAlert(title: "Password", message: "Password confirmation invalid")
                self.dictionarySignUp["Confirmation"]?.text = ""
                self.dictionarySignUp["Password"]?.text = ""
            }
        }
    }
    

    
    func setView(){
      
        let leading : CGFloat = 20
        let height : CGFloat = 30
        let width : CGFloat = 120

        for(name, input) in dictionarySignUp{
            
            let label = labelWithTitle(name, .white)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            cellView.addSubview(label)
            
            input.layer.cornerRadius = 3
            input.textColor = .black
            input.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(input)
            input.heightAnchor.constraint(equalToConstant: height).isActive = true
            input.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.5).isActive = true
            switch name {
            case "Family name" :
              
               
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 30).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
               
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                break
            case "Firstname":
              
               
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 70).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
                
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                break
            case "Email":
               
               
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 110).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
               
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                break
            case "Password":
               
              
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 150).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
               
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                break
            case "Confirmation":
               
              
                label.heightAnchor.constraint(equalToConstant: height).isActive = true
                label.widthAnchor.constraint(equalToConstant: width).isActive = true
                label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 190).isActive = true
                label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
               
                input.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
                input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
                break
            default:
                break
            }
        }
    }
    
}


extension SignUp : SignUpControllerInput {
    func adminAccountCreated() {
        createAlert(title: "Welcome", message: "We are happy that you join the community " + formularValues["firstname"]! + " welcome")
        interactor.addUser(formular: formularValues)
    }
    
    func failedAccountCreation() {
        createAlert(title: "Oups", message: API.instance.accountCreationError)
    }
    
   
    func hasBeenAdded() {
        let controller = MemberTabBar()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: welcomNotifcation), object: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func hasNotBeenAdded(error: String?) {
        createAlert(title: "Error", message: error!)
    }
    
    
}

extension SignUp {
    
    @objc func hideKeyBoard(_ sender: Any){
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}



