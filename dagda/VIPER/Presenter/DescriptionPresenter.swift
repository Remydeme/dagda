//
//  DescriptionPresenter.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



protocol DescriptionPresenterInput {
    func presentDescription(descriptions : [[String:String]])
}

protocol DescriptionPresenterOuput{
    func displayDescription(descriptions: [[String:String]])
}

class DescriptionPresenter : DescriptionPresenterInput{
  
    var controller : DescriptionPresenterOuput!

    func presentDescription(descriptions : [[String:String]])
    {
        
        controller.displayDescription(descriptions: descriptions)
    }
    
    
}
