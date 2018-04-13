//
//  ViewController.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import UIKit

class AppTabBar : UITabBarController{
    
    override func viewDidLoad() {
        
        let layout = UICollectionViewFlowLayout()
        let QRCodeControllerVar = QRCodeHomeController(collectionViewLayout: layout)
        let Home = createTabController(controller: QRCodeControllerVar, tile: "Flash", logo: #imageLiteral(resourceName: "home"))
        
        
//        let layout = UICollectionViewFlowLayout()
//        let HistoryController = 
        viewControllers = [Home]
    }
    
    
    private func createTabController(controller : UIViewController, tile : String, logo : UIImage) -> UINavigationController{
        
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = logo
        return navigationController
    }
    
}
