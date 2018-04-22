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
    func desccriptionLoaded(descriptions: [[String:AnyObject]])
    func errorLoading()
}


protocol DescriptionControllerOutput{
    func fetchDescription()
    func updateDescription(formular: DescriptionCell)
    
}

class DescriptionController : BaseCollectionController{

   
    
    var descriptionArray : [[String:AnyObject]]!
    
    let id = "cell"
    
    var output : DescriptionControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionConfigurer.instance.configure(controller: self)
        self.output.fetchDescription()
        setUp()
    }
    
    
    override func setUp() {
        collectionView?.register(DescriptionCell.self, forCellWithReuseIdentifier: id)
        collectionView?.backgroundView = GradientView(frame: (collectionView?.frame)!)
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if descriptionArray == nil {
            return 0
        }
        else {
            return descriptionArray.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! DescriptionCell
        let description = descriptionArray[indexPath.row]
        cell.descriptionModel = description as! [String:String]
        cell.setDescription()
        cell.topController = self
        cell.position = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: CGFloat(340))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let spaceBetweenDescription : CGFloat = 30
        return spaceBetweenDescription
    }
}



extension DescriptionController : DescriptionControllerInput {
    
    func desccriptionLoaded(descriptions: [[String : AnyObject]]) {
        descriptionArray = descriptions
        collectionView?.reloadData()
    }
    
    func errorLoading() {
        createAlert(title: "Error", message: "Error while loading data")
    }
    
}
