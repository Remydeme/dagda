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
        
        
        let signIn = SignIn()
        let signInController = createTabController(controller: signIn, tile: "Member", logo: #imageLiteral(resourceName: "home"))
        let layout = UICollectionViewFlowLayout()
        let QRCodeControllerVar = QRCodeHomeController(collectionViewLayout: layout)
        let Home = createTabController(controller: QRCodeControllerVar, tile: "Flash", logo: #imageLiteral(resourceName: "home"))
        
        
//        let layout = UICollectionViewFlowLayout()
//        let HistoryController =
        let yout = UICollectionViewFlowLayout()
        //yout.scrollDirection = .horizontal
        let controller = MemberController(collectionViewLayout: yout)
        let nav = UINavigationController(rootViewController: controller)
        
        
        let test = EditDescriptionController()
        let nevTest = UINavigationController(rootViewController: test)
        
        viewControllers = [nevTest, nav, signInController, Home]
    }
    
    
    private func createTabController(controller : UIViewController, tile : String, logo : UIImage) -> UINavigationController{
        
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = logo
        return navigationController
    }
    
}
