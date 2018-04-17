//
//  QRCodeCell.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class QRCodeCell : UICollectionViewCell {
    
    var qrCodeReader : QRCodeController!
    
    var topController : QRCodeHomeController!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setCameraView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
       // backgroundColor = .clear
        backgroundColor = UIColor(red: color(255), green: color(255), blue: color(255), alpha: 1)
        qrCodeReader = QRCodeController()
        qrCodeReader.topController = self.topController
        authorization()
    }
    
    func authorization(){
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authorizationStatus {
        case .notDetermined:
            // permission dialog not yet presented, request authorization
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted:Bool) -> Void in
                if granted {
                    // go ahead
                }
                else {
                    // user denied, nothing much to do
                }
            })
        case .restricted:
            
            break
        case .denied:
            
            break
        case .authorized:
            break
        }
        
    }

 
    func setCameraView() {
        addSubview(qrCodeReader.view!)
        let view = qrCodeReader.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        //view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }
    
    
    func menuButton(){
        
    }
   
    
    
    
}





