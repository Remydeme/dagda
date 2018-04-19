//
//  timeTableController.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


class TimeTableController : UIViewController, UITextViewDelegate {
    
    
    var cellView : UIView!
    
    let dictionnary  = ["Subject":labelWithTitle("Subject"), "Time":labelWithTitle("Time"), "Room":labelWithTitle("Room"),    "Day":labelWithTitle("Day")]
    
    let descriptionView = textViewWith()
    
    let imageView = UIImageView()
    
    var qrCodeController : QRCodeController!
    
    let speakerButton = UIButton(type: .custom)
    
    let updateButton = UIButton(type: .custom)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCellView()
        setLabelConstraint()
        setImage()
        setSpeakerButton()
        descriptionViewContraints()
        setUpdateButton()
        NotificationCenter.default.addObserver(self, selector: #selector (setTextViewSpeech(_:)), name: NSNotification.Name(rawValue: existNotification), object: nil)
    }
    
    
    
    @objc func setTextViewSpeech(_ sender: Any){
        descriptionView.text = (API.instance.data!["desccription"] as! String)
    }
    
    func setView(){
        self.view.backgroundColor = .clear
    }
    
    func setCellView(){
        cellView = UIView()
        //cellView.layer.cornerRadius = 7
        cellView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellView)
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        let cellViewColor = UIColor(red: color(38), green: color(38), blue: color(38), alpha: 0.5)
        cellView.layer.borderWidth = 0.3
        cellView.backgroundColor = cellViewColor
        cellView.heightAnchor.constraint(equalToConstant: 460).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
   
    
    func setLabelConstraint(){
     
        for (name, labelView) in dictionnary {
            labelView.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(labelView)
            labelView.text = name
            switch name {
            case "Day":
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 40).isActive = true
                labelView.font = fontWith(22)
                break;
            case "Subject":
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 80).isActive = true
                labelView.font = fontWith(20)
                break
            case "Time":
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 110).isActive = true
                labelView.font = fontWith(18)
                break
            case "Room":
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 140).isActive = true
                labelView.font = fontWith(18)
                break
            default:
                break
            }
           // size(view: view, width: width, height: height)
            labelView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        }
    }
    
    
    func setSpeakerButton(){
        speakerButton.setImage(#imageLiteral(resourceName: "speaker"), for: .normal)
        speakerButton.translatesAutoresizingMaskIntoConstraints = false
        speakerButton.addTarget(self, action: #selector (TimeTableController.hearSpeech(_:)), for: .touchDown)
        cellView.addSubview(speakerButton)
        
        speakerButton.heightAnchor.constraint(equalToConstant:  80).isActive = true
        speakerButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        speakerButton.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
        speakerButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5).isActive = true
    }
    
    func descriptionViewContraints(){
        
        let roomView = dictionnary["Room"]
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.delegate = self
        view.addSubview(descriptionView)
        
        descriptionView.layer.cornerRadius = 7
        
        descriptionView.topAnchor.constraint(equalTo: (roomView?.bottomAnchor)!, constant: 45).isActive = true
        descriptionView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        descriptionView.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.95).isActive = true
        descriptionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
   func textViewDidBeginEditing(_ textView: UITextView) {
        cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -205).isActive = true
        view.updateConstraints()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.updateConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.updateConstraints()
        self.view.endEditing(true)
    }
    
    @objc func updateDescription(_ sender: Any){
        print("Update")
        let description = Description()
        //description.lastModification
       // description.id = self.qrCodeController.qrCodeInfo["id"]
        description.description = self.descriptionView.text
        API.instance.updateDescription(description: description)
    }
    
    
    func setUpdateButton(){
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(updateButton)
        
        updateButton.addTarget(self, action: #selector (TimeTableController.updateDescription(_:)), for: .touchDown)
        updateButton.backgroundColor = .black
        updateButton.layer.cornerRadius = 7
        updateButton.setTitle("Update", for: .normal)
        updateButton.titleLabel?.font = fontWith(18)
        
        updateButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        updateButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        updateButton.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 15).isActive = true
        updateButton.centerXAnchor.constraint(equalTo: descriptionView.centerXAnchor).isActive = true
    }
    
    @objc func hearSpeech(_ sender: Any){
        print("read the speech")
        self.qrCodeController.generateSpeech()
        self.qrCodeController.readText()
        self.descriptionView.text = qrCodeController.speech
    }
    
    func setImage(){
    
        let size : CGFloat = 60
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "image")
        imageView.layer.cornerRadius = 3
        cellView.addSubview(imageView)
        imageView.backgroundColor = .white
        imageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    func size(view: UIView, width: CGFloat, height : CGFloat){
        view.widthAnchor.constraint(equalToConstant: height).isActive = true
        view.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    

    
    func addConstraints(view: UIView, relative: UIView, top : CGFloat, leading: CGFloat){
        view.topAnchor.constraint(equalTo: relative.topAnchor, constant: top).isActive = true
        view.leadingAnchor.constraint(equalTo: relative.leadingAnchor, constant: leading).isActive = true
    }
    
}











