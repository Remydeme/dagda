//
//  videoCaroussel.swift
//  dagda
//
//  Created by remy DEME on 27/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit

class Caroussel : BaseCollectionController {
    
    let id = "video Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func setUp() {
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: id)
        collectionView?.backgroundColor = itGreen
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! VideoCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.5 , height: collectionView.frame.height * 0.9)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}



class VideoCell: UICollectionViewCell{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        backgroundColor = UIColor(displayP3Red: color(255), green: color(255), blue: color(255), alpha: 0.4)
    }
    
}












