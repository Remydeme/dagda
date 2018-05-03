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

let signOutNotification = "notification.dagda.sign.out.notification"



protocol SignInControllerInput {
    func connected()
    func connectionFailed()
    func adminDataLoaded(state: Bool)
}

protocol SignInControllerOutput {
    func connect(email: String, password: String)
    func fetchAdminInfo(email: String)
}

class SignIn : UIViewController, UITextViewDelegate{
    
    var cellView : UIView!
    let signUp = UIButton(type: .custom)
    let signIn = UIButton(type: .custom)
    let viewTitle = labelWithTitle("Dagda", size: 50)
    let dictionarySignUp = ["Password": textViewWith(), "Email":textViewWith()]
    
    
    var interactor : SignInControllerOutput!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignInConfigurer.instance.configure(controller: self)
        setUp()
        setTitle()
        setCellview()
        setButtonUp()
        setView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector (hideKeyBoard(_:)))
        view.addGestureRecognizer(gesture)
     
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Sign In"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func setUp(){
        view = GradientView(frame: UIScreen.main.bounds)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .always
        tabBarController?.tabBar.backgroundColor = .white
        tabBarController?.tabBar.tintColor = .black
        NotificationCenter.default.addObserver(self, selector: #selector (popToSignIn(_:)), name: NSNotification.Name(rawValue: signOutNotification), object: nil)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: fontWith(25)]

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
        cellView.backgroundColor = .white 
        cellView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 5).isActive = true
    }
    
    func setButtonUp(){
        signUp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUp)
        signUp.addTarget(self, action: #selector (SignIn.signUpAction(_:)), for: .touchDown)
        signUp.setTitle("Sign Up", for: .normal)
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector (dismiss(_:)))
        gesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(gesture)
    }
    
   
    
    @objc func dismiss(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func popToSignIn(_ sender: Any){
        navigationController?.popToRootViewController(animated: true)
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
            if User.instance.connected == false {
                print("Connected 1")
                self.interactor.connect(email: email, password: password)
            }
        }
    }
    
    func setView(){
        var top : CGFloat = 30
        let leading : CGFloat = 20
        let height : CGFloat = 30
        for (name, input) in dictionarySignUp{
            input.layer.cornerRadius = 3
            input.isSecureTextEntry = true 
            if name == "Password" {
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
            input.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.6).isActive = true
            input.textColor = .black
            input.delegate = self
            top += 40
            
        }
    }
    
    @objc func hideKeyBoard(_ sender: Any){
        self.view.endEditing(true)
    }
    
}


extension SignIn : SignInControllerInput {
   
    func adminDataLoaded(state: Bool) {
        if state == true {
            let user = User.instance
            let data = API.instance.adminData
            user.email = (data!["email"] as! String)
            user.firstname = (data!["firstname"] as! String)
            user.pseudo = (data!["pseudo"] as! String)
            user.name = (data!["family name"] as! String)
            user.function = (data!["function"] as! String)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: welcomNotifcation), object: nil)
        }
        else {
            createAlert(title: "Error", message: "Enable to load user data")
        }
    }
    
    func connected() {
        
        // fetch the user
        interactor.fetchAdminInfo(email: (dictionarySignUp["Email"]?.text)!)
        // clear input
        dictionarySignUp["Email"]?.text = ""
        dictionarySignUp["Password"]?.text = ""
        // set user settings
        
        let controller = MemberTabBar()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func connectionFailed(){
        self.createAlert(title: "Ok", message: "Bad password or email please try again.")
    }
    
}











