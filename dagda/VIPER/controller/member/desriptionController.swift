//
//  desriptionController.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


protocol DescriptionControllerInput {
    func displayDescription(descriptions: [[String:String]])
}


protocol DescriptionControllerOutput{
    func fetchDescription()
    func updateDescription(formular: DescriptionCell)
    
}

class DescriptionController : BaseCollectionController, DescriptionControllerInput{
   
    
   
    
    var descriptionArray : [[String:String]]!
    
    let id = "cell"
    
    var output : DescriptionControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionConfigurer.instance.configure(controller: self)
        setUp()
    }
    
    
    override func setUp() {
        collectionView?.register(DescriptionCell.self, forCellWithReuseIdentifier: id)
        collectionView?.backgroundColor = .white
    }
    
 

    func displayDescription(descriptions: [[String : String]]) {
        descriptionArray = descriptions
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! DescriptionCell
        let description = descriptionArray[indexPath.row]
        cell.descriptionModel = description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: CGFloat(340))
    }
}
