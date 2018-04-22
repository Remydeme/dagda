//
//  memberPresenter.swift
//  dagda
//
//  Created by remy DEME on 21/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpPresenterInput {
    func userMayBeHadded()    
}

protocol SignUpPresenterOutput {
    func hasBeenAdded()
    func hasNotBeenAdded(error: String?)
}



class SignUpPresenter :  SignUpPresenterInput{
    
  
    
    var controller : SignUpPresenterOutput!
    
    func userMayBeHadded(){
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpPresenter.wasAdded(_:)), name: NSNotification.Name(rawValue: addedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpPresenter.wasNotAddded(_:)), name: NSNotification.Name(rawValue: addedNotification), object: nil)
    }
    
    @objc func wasAdded(_ sender: Any){
        controller.hasBeenAdded()
    }
    
    @objc func wasNotAddded(_ sender: Any){
        controller.hasNotBeenAdded(error: API.instance.error)
    }
}
