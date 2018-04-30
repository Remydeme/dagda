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
    func mayHaveFetchAdminData()
}


protocol SignInPresenterOutput{
    func connected()
    func connectionFailed()
    func adminDataLoaded(state: Bool)
}


class SignInPresenter  : SignInPresenterInput {
    
    var controller : SignInPresenterOutput!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func cleanObserver(){
        NotificationCenter.default.removeObserver(self) // call this function here beacause the Notificcation center is not clean after each call
    }
    
    func mayHaveFetchAdminData(){
        cleanObserver()
        NotificationCenter.default.addObserver(self, selector: #selector (loadUserData(_:)), name: NSNotification.Name(rawValue: fetchAdminData), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector (errorTryLoadingUserData(_:)), name: NSNotification.Name(rawValue: fetchAdminDataError), object: nil)
    }
    
    @objc func loadUserData(_ sender: Any){
        controller.adminDataLoaded(state: true)
    }
    
    @objc func errorTryLoadingUserData(_ sender: Any){
       controller.adminDataLoaded(state: false)
    }
    
    func mayHaveBeenConnected() {
        
        cleanObserver() // clean notification center 
        
        NotificationCenter.default.addObserver(self, selector: #selector (isConnected(_:)), name: NSNotification.Name(rawValue: signInSuccess), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(isNotConnected(_:)), name: NSNotification.Name(rawValue: signInError), object: nil)
    }
    
    
    @objc func isConnected(_ sender: Any){
        controller.connected()
        User.instance.connect()
    }
    
    @objc func isNotConnected(_ sender: Any){
        controller.connectionFailed()
    }
    
}
