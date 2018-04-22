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
        setUpView()
        addHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var topController : DescriptionController!
    var position = IndexPath()
    let roomLabel = labelWithTitle("Room")
    let descriptionInput = textViewWith()
    let confirmedButton = UIButton(type: .custom)
    
    let topBar = UIView()
    let bottomBar = UIView()
    
    var descriptionModel : [String:String]!
    
    
    func setDescription(){
        descriptionInput.text = descriptionModel["description"]
        roomLabel.text = descriptionModel["room"]
    }
    
    
    func addHorizontalBar(){
        
//        topBar.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(topBar)
//
//        topBar.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        topBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95).isActive = true
//        topBar.bottomAnchor.constraint(equalTo: topAnchor).isActive = true
//        topBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        topBar.backgroundColor = cellBackground
        
        // bttom bar settings
        
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBar)
        bottomBar.backgroundColor = Black
        bottomBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20).isActive = true 
    }
    
    func setUpView(){
        
        //backgroundView = GradientView(frame: frame)
        backgroundColor = cellBackground
        layer.cornerRadius = 7
       // set room label
        
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(roomLabel)
        roomLabel.textColor = Black
        roomLabel.font = fontWith(25)
        roomLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        roomLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        roomLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        roomLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        // set input area
       
        descriptionInput.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionInput)
        descriptionInput.textColor = UIColor(red: color(38), green: color(38), blue: color(38), alpha: 1)
        descriptionInput.backgroundColor = UIColor(red: color(255), green: color(255), blue: color(255), alpha: -0.1)
        descriptionInput.layer.borderColor = Black.cgColor
        descriptionInput.layer.borderWidth = 0.4
        descriptionInput.layer.cornerRadius = 7
        descriptionInput.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionInput.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 30).isActive = true
        descriptionInput.heightAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
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
        confirmedButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmedButton.backgroundColor = .black
        confirmedButton.setTitleColor(.white, for: .normal)
        confirmedButton.setTitleColor(.green, for: .focused)
    }
    

    @objc func confirmedDesription(_ sender: Any )
    {
        print ("confirmed desription")
        topController.output.updateDescription(formular: self)
        topController.descriptionArray.remove(at: position.row)
        topController.collectionView?.deleteItems(at: [position])
        //topController.collectionView?.reloadData()

    }
    
}









