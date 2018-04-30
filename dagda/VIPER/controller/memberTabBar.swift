//
//  memberTabBar.swift
//  dagda
//
//  Created by remy DEME on 27/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit 



class MemberTabBar : UITabBarController{
    
    override func viewDidLoad() {
        
        
       
        
        let layout = UICollectionViewFlowLayout()
        let descriptionController = DescriptionController(collectionViewLayout: layout)
        let description = createTabController(controller: descriptionController, tile: "home", logo: #imageLiteral(resourceName: "description"))
        
        let edit = EditDescription()
        let editController = createTabController(controller: edit, tile: "edit", logo: #imageLiteral(resourceName: "edit"))
        
        viewControllers = [description, editController]
    }
    
    
    
    
}
