//
//  editDescription.swift
//  dagda
//
//  Created by remy DEME on 27/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


protocol editDescriptionControllerInput {
    func videoUploaded(state: Bool)
    func descriptionUploaded(state: Bool)
}

protocol EditDescriptionControllerOuput{
    func uploadVideo(path: URL, name: String)
    func uploadDescription(room: String, description: String)
}

class EditDescription : UIViewController, UITextViewDelegate {
    
    let navTitle = "Edit"
    var cellView : UIView!
    
    // viper
    var interactor : EditDescriptionControllerOuput!
    
    let room = textViewWith()
    let speechReconizer = SpeechReconizerController()
    var descriptionInput : UITextView!
    
    let saveButton : UIButton = {
       
        let button = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 17
        button.titleLabel?.font = fontWith(18)
        return button
    }()
    
    let carousselController  : Caroussel = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let caroussel = Caroussel(collectionViewLayout: layout)
        return caroussel
    }()
    
    
    var name : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpView()
        setUpCellVIew()
        setUpInputs()
        setUpVideoView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func setUp(){
        navigationItem.title = navTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector (startCamera(_:)))
        //
    }
    
    
    func setUpView(){
        view.backgroundColor = .white
    }
    
    
    func setUpCellVIew(){
        cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = itGreen
        view.addSubview(cellView)
        cellView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cellView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true 
    }
    
    
    func setUpInputs(){
        
        room.translatesAutoresizingMaskIntoConstraints = false
        descriptionInput = speechReconizer.outputView
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
        room.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.5).isActive = true
        
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
        
        descriptionInput.leadingAnchor.constraint(equalTo: room.leadingAnchor).isActive = true
        descriptionInput.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 7).isActive = true
        // size constraint description input
        
        descriptionInput.heightAnchor.constraint(equalToConstant: 150).isActive = true
        descriptionInput.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.5).isActive = true
        
        
        // position the mic pic
        
        let micButton = speechReconizer.startButton
        let micHeight : CGFloat = 40
        let micWidth : CGFloat = 25
        
        micButton.translatesAutoresizingMaskIntoConstraints = false 
        micButton.setImage(#imageLiteral(resourceName: "mic"), for: .normal)
        cellView.addSubview(micButton)
        
        // constraint
        micButton.heightAnchor.constraint(equalToConstant: micHeight).isActive = true
        micButton.widthAnchor.constraint(equalToConstant: micWidth).isActive = true
        
        // position
        
        let micLeading : CGFloat = 10
        
        micButton.leadingAnchor.constraint(equalTo: descriptionInput.trailingAnchor, constant: micLeading).isActive = true
        micButton.centerYAnchor.constraint(equalTo: descriptionInput.centerYAnchor).isActive = true
        micButton.addTarget(self, action: #selector (EditDescriptionController.startRecord(_:)), for: .touchDown)
        
        
        // save button
        saveButton.translatesAutoresizingMaskIntoConstraints  = false
    
        cellView.addSubview(saveButton)
        
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 105).isActive = true
        
        // position
        
        saveButton.topAnchor.constraint(equalTo: descriptionInput.bottomAnchor, constant: 30).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
    }
    
    func setUpVideoView(){
        let caroussel = carousselController.collectionView
        caroussel?.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(caroussel!)
        
        // position
        let top : CGFloat = 100
        caroussel?.topAnchor.constraint(equalTo: descriptionInput.bottomAnchor, constant: top).isActive = true
        caroussel?.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        // size
        let height : CGFloat = 200
        
        caroussel?.heightAnchor.constraint(equalToConstant: height).isActive = true
        caroussel?.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.8).isActive = true
        
    }
    
}


extension EditDescription {
    
    @objc func startRecord (_ sender : Any){
        speechReconizer.microphoneTaped(self)
    }
}

extension EditDescription{
    
    @objc func startCamera(_ sender: Any){
        print("Start camera")
        if let roomName = self.room.text {
            let controller = VideoController()
            controller.filename = roomName
            navigationController?.pushViewController(controller, animated: true)
        }
        else {
            createAlert(title: "Ok", message: "Please Enter the name of the room")
        }
    }
}


extension EditDescription {
    
    @objc func save(_ sender : Any){
        guard let name = room.text, let descriptionTexte = descriptionInput.text else {
            createAlert(title: "Empty Field", message: "Every field should be field")
            return
        }
        interactor.uploadDescription(room: name, description: descriptionTexte)
        
        let path = Settings.instance.tempVideoURL().appendingPathComponent(name)
        
        if FileManager.default.fileExists(atPath: path.absoluteString) == true {
            interactor.uploadVideo(path: path, name: name)
        }
    }
}

extension EditDescription : editDescriptionControllerInput {
    func videoUploaded(state: Bool) {
        if state == false {
            createAlert(title: "Ok", message: "Serveur error the video has not been pushed try again.")
        }

    }
    
    func descriptionUploaded(state: Bool) {
        if state == false {
            createAlert(title: "Ok", message: "Serveur error description has not been pushed try again.")
        }
        else {
            createAlert(title: "I'm happy to help", message: "The Dagda community thank you for your contribution.")

        }
    }
    
    
}




