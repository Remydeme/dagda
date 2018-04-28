//
//  signInPresenter.swift
//  dagda
//
//  Created by remy DEME on 27/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation


protocol SignInPresenterInput {
    func mayHaveBeenConnected()
}


protocol SignInPresenterOutput{
    func connected()
    func connectionFailed()
}


class SignInPresenter  : SignInPresenterInput {
    
    var controller : SignInPresenterOutput!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func mayHaveBeenConnected() {
        NotificationCenter.default.addObserver(self, selector: #selector (isConnected(_:)), name: NSNotification.Name(rawValue: signInSuccess), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(isNotConnected(_:)), name: NSNotification.Name(rawValue: signInError), object: nil)
    }
    
    @objc func isConnected(_ sender: Any){
        controller.connected()
    }
    
    @objc func isNotConnected(_ sender: Any){
        controller.connectionFailed()
    }
    
}
