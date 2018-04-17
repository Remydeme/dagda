//
//  QRCodeController.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


class QRCodeHomeController : UICollectionViewController, UICollectionViewDelegateFlowLayout, AVCaptureMetadataOutputObjectsDelegate {
    
    
    let navTitle = "Welcome in Dagda"
    let id = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        setUp()
    }
    
    
    func setUp(){
        navigationItem.title = navTitle
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true 
        collectionView?.backgroundColor = .black
        collectionView?.register(QRCodeCell.self, forCellWithReuseIdentifier: id)
        collectionView?.backgroundColor = .clear 
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! QRCodeCell
        cell.topController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    

}











