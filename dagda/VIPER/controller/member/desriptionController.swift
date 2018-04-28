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
    func removeCellAfterDelete(index: IndexPath)
    func errorLoading()
}


protocol DescriptionControllerOutput{
    func fetchDescription()
    func deleteDescription(formular: DescriptionCell)
    func updateDescription(formular: DescriptionCell)
    
}

class DescriptionController : BaseCollectionController{

   
    
    var descriptionArray : [[String:AnyObject]]!
    
    let id = "cell"
    var topController : SignIn!
    var output : DescriptionControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionConfigurer.instance.configure(controller: self)
        self.output.fetchDescription()
        setUp()
    }
    
    @objc func signOut(_ sender : Any){
        print("Sign out")
        API.instance.signOut()
        User.instance.disconnect()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: signOutNotification), object: nil)
    }
    
    override func setUp() {
        tabBarController?.tabBar.backgroundColor = .white
        tabBarController?.tabBar.tintColor = .black
        collectionView?.register(DescriptionCell.self, forCellWithReuseIdentifier: id)
       // collectionView?.backgroundView = GradientView(frame: (collectionView?.frame)!)
        
        // background color
        collectionView?.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        // add logout button
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector (signOut(_:)))
        
        // font
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: fontWith(25)]
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
        cell.descriptionModel = (description as! [String:String])
        cell.setDescription()
        cell.topController = self
        cell.position = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: CGFloat(340))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right:0)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        let spaceBetweenDescription : CGFloat = 50
//        return spaceBetweenDescription
//    }
}



extension DescriptionController : DescriptionControllerInput {
   
    func removeCellAfterDelete(index: IndexPath) {
        descriptionArray.remove(at: index.row)
        collectionView?.deleteItems(at: [index])
    }
    
    func desccriptionLoaded(descriptions: [[String : AnyObject]]) {
        descriptionArray = descriptions
        collectionView?.reloadData()
    }
    
    func errorLoading() {
        createAlert(title: "Error", message: "Error while loading data")
    }
    
}
