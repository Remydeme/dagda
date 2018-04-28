//
//  File.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


class DescriptionCell : BaseCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gesture = UITapGestureRecognizer(target: self, action: #selector (hideKeyboard(_:)))
        addGestureRecognizer(gesture)
        setUpView()
        //addHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var topController : DescriptionController!
    var position = IndexPath()
    let roomLabel = labelWithTitle("Room")
    let descriptionInput = textViewWith()
    let confirmedButton = UIButton(type: .custom)
    let deleteButton = UIButton(type: .custom)
    
    let topBar = UIView()
    let bottomBar = UIView()
    
    var descriptionModel : [String:String]!
    
    
    func setDescription(){
        descriptionInput.text = descriptionModel["description"]
        roomLabel.text = descriptionModel["room"]
    }
    
    
    func addHorizontalBar(){

        
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBar)
        bottomBar.backgroundColor = Black
        bottomBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20).isActive = true 
    }
    
    func setUpView(){
        
        backgroundColor = itGreen
        //backgroundView = GradientView(frame: frame)
       // layer.cornerRadius = 7
       // set room label
        
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(roomLabel)
        roomLabel.textColor = .white
        roomLabel.textAlignment = .center
        roomLabel.backgroundColor = UIColor(displayP3Red: color(255), green:  color(255), blue:  color(255), alpha: 0.4)
        roomLabel.font = fontWith(25)
        roomLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        roomLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        roomLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        roomLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        // set input area
       
        descriptionInput.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionInput)
        descriptionInput.textColor = .white
        descriptionInput.layer.borderWidth = 0.8
        descriptionInput.layer.borderColor = UIColor.white.cgColor
        descriptionInput.layer.cornerRadius = 3
        descriptionInput.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionInput.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 30).isActive = true
        descriptionInput.heightAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        descriptionInput.backgroundColor = .clear
        descriptionInput.text = "Description here"
        
        // set button
        confirmedButton.translatesAutoresizingMaskIntoConstraints = false
        confirmedButton.addTarget(self, action: #selector (confirmedDesription(_:)), for: .touchDown)
        addSubview(confirmedButton)
        confirmedButton.setTitle("Validate", for: .normal)
        confirmedButton.layer.cornerRadius = 7
        confirmedButton.titleLabel?.font = fontWith(18)
        confirmedButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        confirmedButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        confirmedButton.topAnchor.constraint(equalTo: descriptionInput.bottomAnchor, constant: 15).isActive = true
        confirmedButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -70).isActive = true 
        confirmedButton.backgroundColor = .white
        confirmedButton.setTitleColor(.black, for: .normal)
        confirmedButton.setTitleColor(.green, for: .focused)
        
        
        //delete description button
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector (deleteDescription(_:)), for: .touchDown)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteButton)
        deleteButton.backgroundColor = .white
        deleteButton.layer.cornerRadius = 7
        deleteButton.titleLabel?.font = fontWith(18)
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: confirmedButton.centerYAnchor).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: confirmedButton.trailingAnchor, constant: 20).isActive = true
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.setTitleColor(.green, for: .focused)
        
    }
    

    @objc func hideKeyboard(_ sender: Any){
        endEditing(true)
    }
    
    @objc func deleteDescription(_ sender: Any){
        print("delete")
        let delete = UIAlertAction(title: "delete", style: .default, handler: { action in
            self.topController.output.deleteDescription(formular: self)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in })
        let title = "Delete description"
        let message = "Are you sure that you want to delete this description ?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(delete)
        alertController.addAction(cancel)
        topController.present(alertController, animated: true, completion: nil)
    }
    
    @objc func confirmedDesription(_ sender: Any )
    {
        print ("confirmed desription")
        topController.output.updateDescription(formular: self)
        topController.descriptionArray.remove(at: position.row)
        topController.collectionView?.deleteItems(at: [position])
    }
    
}









