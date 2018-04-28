//
//  videoCaroussel.swift
//  dagda
//
//  Created by remy DEME on 27/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVKit

let videoNotification = "dagda.video.notificcation"

class Caroussel : BaseCollectionController {
    
    let id = "video Cell"
    
    // video filename
    var fileName = ""
    
    // I have to load the video from the database
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        NotificationCenter.default.addObserver(self, selector: #selector (setCellVideoPath(_:)), name: NSNotification.Name(rawValue: videoNotification), object: nil)
    }
    
    @objc func setCellVideoPath(_ sender: Any){
        let cell = collectionView?.cellForItem(at: IndexPath(row: 0, section: 0)) as! VideoCell
        let path = Settings.instance.tempVideoURL().appendingPathComponent(fileName)
        cell.configurePlayer(path: path)
    }
    
    override func setUp() {
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: id)
        collectionView?.backgroundColor = itGreen
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! VideoCell
        cell.topController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}



class VideoCell: UICollectionViewCell{
    
    var video : AVPlayer!
    var videoPath = ""
    var videoPlayer : AVPlayerViewController!
    var topController : Caroussel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        backgroundColor = UIColor(displayP3Red: color(255), green: color(255), blue: color(255), alpha: 0.4)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(playVideo(_:)))
        addGestureRecognizer(gesture)
    }
    
    func configurePlayer(path: URL){
        video = AVPlayer(url: path)
        videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        videoPlayer.title = path.absoluteString
        let videoView = videoPlayer.view
        videoView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(videoView!)
        
        videoView?.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        videoView?.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    @objc func playVideo(_ sender: Any){
        topController.navigationController?.pushViewController(videoPlayer, animated: true)
    }
    
}






//
//func uploadVideo(_ path: URL, _ userID: String,
//                 metadataEsc: @escaping (URL, StorageReference)->(),
//                 progressEsc: @escaping (Progress)->(),
//                 completionEsc: @escaping ()->(),
//                 errorEsc: @escaping (Error)->()) {
//    
//    let localFile: URL = path
//    let videoName = getName()
//    let nameRef = Storage.storage().reference().child(userID).child(videoName)
//    let metadata = StorageMetadata()
//    metadata.contentType = "video"
//    nameRef.putFile(from: <#T##URL#>)
//    let uploadTask = nameRef.putFile(from: localFile, metadata: metadata) { metadata, error in
//        if error != nil {
//            errorEsc(error!)
//        } else {
//            if let meta = metadata {
//                if let url = meta.downloadURL() {
//                    metadataEsc(url, nameRef)
//                }
//            }
//        }
//    }
//    
//    _ = uploadTask.observe(.progress, handler: { snapshot in
//        if let progressSnap = snapshot.progress {
//            progressEsc(progressSnap)
//        }
//    })
//    
//    _ = uploadTask.observe(.success, handler: { snapshot in
//        if snapshot.status == .success {
//            uploadTask.removeAllObservers()
//            completionEsc()
//        }
//    })
//}
//
//func getName() -> String {
//    let dateFormatter = DateFormatter()
//    let dateFormat = "yyyyMMddHHmmss"
//    dateFormatter.dateFormat = dateFormat
//    let date = dateFormatter.string(from: Date())
//    let name = date.appending(".mp4")
//    return name
//}
//
//


