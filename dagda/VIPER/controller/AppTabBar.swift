//
//  ViewController.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import UIKit
import Foundation

class AppTabBar : UITabBarController{
    
    override func viewDidLoad() {
        
        
        let signIn = SignIn()
        let signInController = createTabController(controller: signIn, tile: "Member", logo: #imageLiteral(resourceName: "home"))
       
        let layout = UICollectionViewFlowLayout()
        let QRCodeControllerVar = QRCodeHomeController(collectionViewLayout: layout)
        let Home = createTabController(controller: QRCodeControllerVar, tile: "Flash", logo: #imageLiteral(resourceName: "home"))
        
//
//        let edit = EditDescription()
//        let editController = createTabController(controller: edit, tile: "edit", logo: #imageLiteral(resourceName: "description"))
//
       let video = TimeTableController()
       let controler = createTabController(controller: video, tile: "video", logo: #imageLiteral(resourceName: "home"))
  
        viewControllers = [controler, Home]
    }
    
    
  
    
}

extension UITabBarController {
    func createTabController(controller : UIViewController, tile : String, logo : UIImage) -> UINavigationController{
        
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = logo
        return navigationController
    }
}
