//
//  settingsController.swift
//  dagda
//
//  Created by remy DEME on 29/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import Firebase

/*
   name
   age
   ranking
   pseudo
 
 */

protocol SettingsControllerInput {
    
}

protocol SettingsControllerOutput {
    
}


class SettingsController : UIViewController {
    
    
    let firstname = textViewWith()
    let lastname = textViewWith()
    let birth = textViewWith()
    let pseudo = textViewWith()
    let function = textViewWith()
    let dico = ["Pseudo":textViewWith(), "Firstname":textViewWith(), "Lastname":textViewWith(), "Email":textViewWith()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.edgesForExtendedLayout = []
    }
    
    func setUp(){
        view.backgroundColor = itBlue
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    func horizontalBar(){
        let bar = UIView()
        
    }
    
    func setUpView(){
        
        let height : CGFloat = 35
        let width : CGFloat = 200

        let labelHeight : CGFloat = 40
        let labelWidth : CGFloat = 90
        
        for (name, input) in dico {
            
            let leading : CGFloat = 20

            
            let label = labelWithTitle(name, size: 19)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            input.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(input)
            view.addSubview(label)
            
            
            label.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
            label.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
            
            
            input.heightAnchor.constraint(equalToConstant: height).isActive = true
            input.widthAnchor.constraint(equalToConstant: width).isActive = true
            input.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10).isActive = true
            input.topAnchor.constraint(equalTo: label.topAnchor, constant: 0).isActive = true

            
            
            switch name {
            case "Pseudo":
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
                break
            case "Firstname":
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
                break
            case "Lastname":
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
                break
            case "Email":
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 220).isActive = true
                break
            default:
                break
            }
        }
    }
}







