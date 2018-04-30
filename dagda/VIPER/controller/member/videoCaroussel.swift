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
    var filePath : URL!
    
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
        let path = filePath.absoluteString
        cell.configurePlayer(path: path)
    }
    
    override func setUp() {
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: id)
        collectionView?.backgroundColor = itGreen
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
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
    
    func configurePlayer(path: String){
      
            let url = URL(fileURLWithPath: path)
            video = AVPlayer(url: url)
            videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            videoPlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
            videoPlayer.title = path
            
            let videoView = videoPlayer.view
            videoView?.frame = frame
            addSubview(videoView!)
    }
    
    @objc func playVideo(_ sender: Any){
        print("play video")
        let controller = UINavigationController(rootViewController: videoPlayer)
        topController.navigationController?.pushViewController(controller, animated: true)
    }
    
}






