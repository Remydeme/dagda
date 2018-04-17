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
        backgroundColor = .red
        setUpInput()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let roomLabel = labelWithTitle("Room")
    let descriptionInput = textViewWith()
    let confirmedButton = UIButton(type: .custom)
    
    var descriptionModel : [String:String]!
    
    func setUpInput(){
        
        //backgroundView = GradientView(frame: frame)
        backgroundColor = .darkGray
        layer.cornerRadius = 7
       // set room label
        
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(roomLabel)
        roomLabel.textColor = .white
        roomLabel.font = fontWith(25)
        roomLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        roomLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        roomLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        roomLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        // set input area
       
        descriptionInput.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionInput)
        descriptionInput.textColor = .black
        descriptionInput.backgroundColor = .white
        descriptionInput.layer.cornerRadius = 7
        descriptionInput.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionInput.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 30).isActive = true
        descriptionInput.heightAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        descriptionInput.text = "Description here"
        
        // set button
        confirmedButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(confirmedButton)
        confirmedButton.setTitle("Validate", for: .normal)
        confirmedButton.layer.cornerRadius = 7
        confirmedButton.titleLabel?.font = fontWith(18)
        confirmedButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        confirmedButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        confirmedButton.topAnchor.constraint(equalTo: descriptionInput.bottomAnchor, constant: 20).isActive = true
        confirmedButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmedButton.backgroundColor = .black
        confirmedButton.setTitleColor(.white, for: .normal)
        confirmedButton.setTitleColor(.green, for: .focused)
    }
    

    @objc func confirmedDesription(_ sender: Any )
    {
        
    }
    
}









