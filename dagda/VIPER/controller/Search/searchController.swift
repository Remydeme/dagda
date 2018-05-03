//
//  searchController.swift
//  dagda
//
//  Created by remy DEME on 02/05/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation
import MobileCoreServices
import AssetsLibrary
import AVKit




class SearchController : UIViewController, UITextViewDelegate {
    
    var cellView = UIScrollView()
    let search = textViewWith()
    let descriptionInput = textViewWith()
    var videoPlayer : AVPlayerViewController!
    var video : AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setViewUp()
        NotificationCenter.default.addObserver(self, selector: #selector(descriptionFounded(_ :)), name: NSNotification.Name(rawValue: existNotification), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(descriptionNotFounded(_ :)), name: NSNotification.Name(rawValue: notExistNotification), object: nil)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        gesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(gesture)
    }
    
    
    @objc func dismiss(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
   
    func setUp(){
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        tabBarController?.tabBar.isHidden = true
    }
    
    func setViewUp(){
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = itGreen
        self.view.addSubview(cellView)
        
        
        cellView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        cellView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        
        cellView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cellView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
        cellView.layer.cornerRadius = cornerRadius
        
        cellView.contentSize = CGSize(width: view.frame.width * 0.8, height: view.frame.height + 200)
       let title = labelWithTitle("Search description")
       
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = UIFont(name: "Noteworthy", size: 23)
        cellView.addSubview(title)
        
        title.heightAnchor.constraint(equalToConstant: 40).isActive = true
        title.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.85).isActive = true
        
        title.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        title.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20).isActive = true
        
        
        // search bar
        
        
        search.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(search)
        
        // size
        
        search.heightAnchor.constraint(equalToConstant: 40).isActive = true
        search.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.9).isActive = true
        search.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
        search.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        search.backgroundColor = itWhite
        search.layer.cornerRadius = 17
        search.textColor = .black
        search.text = "Search"
        search.delegate = self
        search.font = UIFont(name: "Noteworthy", size: 17)
    }
    
    
    func loadUrl(){
        let storageRef = Storage.storage().reference()
        let room = (search.text!) + ".mp4"
        let starsRef = storageRef.child("video").child(room)
        // Fetch the download URL
        starsRef.downloadURL { url, error in
            if error != nil {
                // treatement here if no video
            } else {
                self.configureVideoPlayer(url: url!)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        search.text = ""
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        let room = search.text!
        API.instance.roomDescriptionExists(room: room)
    }
    
    @objc func descriptionFounded(_ sender: Any){
        let description = API.instance.description!["description"] as! String
        descriptionInput.text = description
        
        // radius
        
        descriptionInput.layer.cornerRadius = 17
        
        descriptionInput.translatesAutoresizingMaskIntoConstraints = false
        // set desccription input constraints
        
        cellView.addSubview(descriptionInput)
        // position
        
        descriptionInput.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 40).isActive = true
        descriptionInput.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
    
        // size constraints
        let height : CGFloat = 220
        
        descriptionInput.heightAnchor.constraint(equalToConstant: height).isActive = true
        descriptionInput.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.9).isActive = true
        
        loadUrl()

    }
    
    @objc func descriptionNotFounded(_ sender: Any){
        descriptionInput.text = "No description"
    }
    
    
    func configureVideoPlayer(url:URL){
        let asset = AVURLAsset(url: url)
        video = AVPlayer(playerItem: AVPlayerItem(asset: asset))
        videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        videoPlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
        videoPlayer.title = "Description video"
        videoPlayer.view.layer.cornerRadius = cornerRadius
        let videoView = videoPlayer.view
        
        videoView?.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(videoView!)
        
        videoView?.topAnchor.constraint(equalTo: descriptionInput.bottomAnchor, constant: 30).isActive = true
        videoView?.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        // layer corner
        videoView?.layer.cornerRadius = 17
        // size
        let height : CGFloat = 220
        let width : CGFloat = 250
        
        videoView?.heightAnchor.constraint(equalToConstant: height).isActive = true
        videoView?.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
}













