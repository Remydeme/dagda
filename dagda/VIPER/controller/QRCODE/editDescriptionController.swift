//
//  editDescriptionController.swift
//  dagda
//
//  Created by remy DEME on 17/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit

class EditDescriptionController: UIViewController , UITextViewDelegate{
    
    var cellView : UIView!
    var topController : QRCodeController!
    var dictionnary  = ["Room":labelWithTitle("Room"), "Description":UITextView()]
    let confirmedButton = UIButton(type: .custom)
    let imageView = UIImageView()
    let speechReconizerController = SpeechReconizerController()
    let numberTouch = 0
    
    var qrCodeInfo : [String:String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictionnary["Description"] = speechReconizerController.outputView
        setView()
        setCellView()
        setViewConstraint()
        setImage()
        setButton()
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
        cellView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        let cellViewColor = UIColor(red: color(38), green: color(38), blue: color(38), alpha: 0.5)
        cellView.layer.borderWidth = 0.3
        cellView.backgroundColor = cellViewColor
        cellView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
  
    
    func setViewConstraint(){
        
        for (name, cellViewElement) in dictionnary {
            cellViewElement.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(cellViewElement)
            switch name {
            case "Description":
                let height : CGFloat = 120
                let width : CGFloat = 260
                let labelView = cellViewElement as! UITextView
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 90).isActive = true
                labelView.heightAnchor.constraint(equalToConstant: height).isActive = true
                labelView.widthAnchor.constraint(equalToConstant: width).isActive = true
                labelView.textColor = .white
                labelView.delegate = self
                labelView.font = fontWith(15)
                break
            case "Room":
                let height : CGFloat = 35
                let width : CGFloat = 100
                let labelView = cellViewElement as! UILabel
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 30).isActive = true
                labelView.heightAnchor.constraint(equalToConstant: height).isActive = true
                labelView.widthAnchor.constraint(equalToConstant: width).isActive = true
                labelView.font = fontWith(22)
                break
            default:
                break
            }
            // size(view: view, width: width, height: height)
            cellViewElement.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
            
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setButton(){
        
        // push button
        let height : CGFloat = 35
        let width : CGFloat = 100
        
        confirmedButton.addTarget(self, action: #selector (EditDescriptionController.push(_:)), for: .touchDown)
        
        confirmedButton.translatesAutoresizingMaskIntoConstraints = false
        confirmedButton.setTitle("Push", for: .normal)
        let textInput = dictionnary["Description"] as! UITextView
        
        cellView.addSubview(confirmedButton)
        
        confirmedButton.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 15).isActive = true
        confirmedButton.centerXAnchor.constraint(equalTo: cellView.centerXAnchor, constant: -30).isActive = true
        
        confirmedButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        confirmedButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        
        // speech button
        
        let speechWidth : CGFloat = 30
        let speechButton = speechReconizerController.startButton
        speechButton.setImage(#imageLiteral(resourceName: "mic"), for: .normal)
        speechButton.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(speechButton)
        
        speechButton.leadingAnchor.constraint(equalTo: textInput.trailingAnchor, constant: 7).isActive = true
        speechButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive  = true
        
        speechButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        speechButton.widthAnchor.constraint(equalToConstant: speechWidth).isActive = true

        speechButton.addTarget(self, action: #selector (EditDescriptionController.startRecord(_:)), for: .touchDown)
    }
    
    @objc func push(_ sender: Any){
        print ("Something as been pushed ")
        let description = Description()
        description.room = qrCodeInfo["Room"]!
        description.description = (dictionnary["Description"] as! UITextView).text
        description.note = "0"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: NSDate() as Date)
        description.lastModification = dateString
        description.valided = "False"
        description.writtenBy = "User"
        API.instance.addDescription(description: description)
        createAlert(title: "Thank you", message: "Thank you for your contribution")
    }
    
 
    @objc func startRecord (_ sender : Any){
        speechReconizerController.microphoneTaped(self)
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
