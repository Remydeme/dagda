//
//  timeTableController.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVKit



class TimeTableController : UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    
    var cellView : UIScrollView!
    
    let dictionnary  = ["Subject":labelWithTitle("Subject"), "Time":labelWithTitle("Time"), "Room":labelWithTitle("Room"),    "Day":labelWithTitle("Day")]
    
    let descriptionView = textViewWith()
    
    let imageView = UIImageView()
    
    var qrCodeController : QRCodeController!
    
    let speakerButton = UIButton(type: .custom)
    
    let updateButton = UIButton(type: .custom)
    
    
    // handle the video
    
    var video : AVPlayer!
    var videoPlayer : AVPlayerViewController!
    
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
    }
    
    

    func setView(){
        self.view.backgroundColor = itGreen
    }
    
    func setCellView(){
        cellView = UIScrollView()
        cellView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 200)
        
        //cellView.layer.cornerRadius = 7
        cellView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellView)
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        cellView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let cellViewColor = UIColor(red: color(38), green: color(38), blue: color(38), alpha: 0.5)
        cellView.layer.borderWidth = 0.3
        cellView.backgroundColor = cellViewColor
        cellView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
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
        
        speakerButton.heightAnchor.constraint(equalToConstant:  60).isActive = true
        speakerButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
       // speakerButton.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
        speakerButton.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 60).isActive = true
        speakerButton.centerXAnchor.constraint(equalTo:  cellView.centerXAnchor, constant: 100).isActive = true
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
        description.room = (self.dictionnary["Room"]?.text!)!
        description.description = descriptionView.text
        description.note = "0" // should be the value enter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:MM"
        let dateString = formatter.string(from: NSDate() as Date)
        description.lastModification = dateString
        description.valided = "False"
        description.writtenBy = "User"
        description.id = description.room + " " + dateString
         API.instance.userUpdateDescription(description: description)
        self.dismiss(animated: true, completion: nil)
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
        print("read the ")
        self.qrCodeController.readText()
    }
    
    func setImage(){
    
        let size : CGFloat = 60
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "image")
        imageView.layer.cornerRadius = 3
        cellView.addSubview(imageView)
        imageView.backgroundColor = .blue
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


extension TimeTableController {
    
    
    func loadFilURL(){
        let storageRef = Storage.storage().reference()
        let room = (dictionnary["Room"]?.text)! + ".mp4"
        let starsRef = storageRef.child("video").child(room)
        // Fetch the download URL
        starsRef.downloadURL { url, error in
            if let error = error {
                self.createAlert(title: "video", message: "Pas de video pour cette description")
            } else {
               // self.createAlert(title: "url" , message: (url?.absoluteString)!)
                self.setUpPlayerView(url: url!)
            }
        }

    }
    
    func setUpPlayerView(url: URL){
        let asset = AVURLAsset(url: url)
        video = AVPlayer(playerItem: AVPlayerItem(asset: asset))
        videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        videoPlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
        videoPlayer.title = "test"
        videoPlayer.view.layer.cornerRadius = 27
        
        let videoView = videoPlayer.view
        videoView?.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(videoView!)
        videoView?.layer.cornerRadius = 27
        videoView?.heightAnchor.constraint(equalToConstant: 240).isActive = true
        videoView?.widthAnchor.constraint(equalToConstant: 260).isActive = true
        
        videoView?.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 60).isActive = true
        videoView?.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
    }
    
    func configurePlayer(){
        
        
    }
}









