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
    func accountMayBecreated()
}

protocol SignUpPresenterOutput {
    func hasBeenAdded()
    func hasNotBeenAdded(error: String?)
    func adminAccountCreated()
    func failedAccountCreation()
}



class SignUpPresenter :  SignUpPresenterInput{
 
    
    
  
    
    var controller : SignUpPresenterOutput!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func cleanObserver(){
        NotificationCenter.default.removeObserver(self) // call this function here beacause the Notificcation center is not clean after each call
    }
    
    func userMayBeHadded(){
        
        cleanObserver()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpPresenter.wasAdded(_:)), name: NSNotification.Name(rawValue: addedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpPresenter.wasNotAddded(_:)), name: NSNotification.Name(rawValue: addedNotification), object: nil)
    }
    
    @objc func wasAdded(_ sender: Any){
        controller.hasBeenAdded()
    }
    
    @objc func wasNotAddded(_ sender: Any){
        controller.hasNotBeenAdded(error: API.instance.error)
    }
    
    func accountMayBecreated() {
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpPresenter.wasCreated(_:)), name: NSNotification.Name(rawValue: adminAdded), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpPresenter.wasNotCreated(_:)), name: NSNotification.Name(rawValue: adminAddFailed), object: nil)
    }
    
    @objc func wasCreated(_ sender: Any){
        controller.adminAccountCreated()
    }
    
    @objc func wasNotCreated(_ sender: Any){
        controller.failedAccountCreation()
    }
    
}
