//
//  editDescription.swift
//  dagda
//
//  Created by remy DEME on 27/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


class EditDescription : UIViewController, UITextViewDelegate {
    
    let navTitle = "Edit"
    var cellView : UIView!
    
    let room = textViewWith()
    let speechReconizer = SpeechReconizerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpView()
        setUpCellVIew()
        setUpInputs()
    }
    
    func setUp(){
        navigationItem.title = navTitle        
        //
    }
    
    
    func setUpView(){
        view.backgroundColor = .white
    }
    
    
    func setUpCellVIew(){
        cellView = GradientView()
        cellView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(cellView)
        cellView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.95).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cellView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true 
    }
    
    
    func setUpInputs(){
        
        room.translatesAutoresizingMaskIntoConstraints = false
        let descriptionInput = speechReconizer.outputView
        descriptionInput.translatesAutoresizingMaskIntoConstraints = false
        let policeSize : CGFloat = 20
        
        let roomLabel = labelWithTitle("Room", size: policeSize)
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = labelWithTitle("Description", size: policeSize)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(descriptionLabel)
        view.addSubview(roomLabel)
        view.addSubview(descriptionInput)
        view.addSubview(room)

        let height : CGFloat = 30
        let width : CGFloat = 100
        let topRoom :CGFloat = 100
        let leading : CGFloat = 10
        room.heightAnchor.constraint(equalToConstant: height).isActive = true
        room.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        roomLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        roomLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        // position contraints
        
        roomLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: topRoom).isActive = true
        roomLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: leading).isActive = true
        
        room.leadingAnchor.constraint(equalTo: roomLabel.trailingAnchor, constant: 10).isActive = true
        room.centerYAnchor.constraint(equalTo: roomLabel.centerYAnchor).isActive = true
        
        // description
        
        descriptionLabel.leadingAnchor.constraint(equalTo: roomLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 20).isActive = true
        
        descriptionInput.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 20).isActive = true
        descriptionInput.topAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
        // size constraint description input
        
        descriptionInput.heightAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionInput.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.5).isActive = true
        
    }
    
}








