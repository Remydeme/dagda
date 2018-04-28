//
//  signUpInteractor.swift
//  dagda
//
//  Created by remy DEME on 21/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation


protocol SignUpInteractorInput{
    func addUser(formular: inout [String:String])
    func createAccount(email: String, password: String)
}

protocol SignUpInteractorOutput {
    func userMayBeHadded()
    func accountMayBecreated()
}


class SignUpInteractor : SignUpInteractorInput{
 
    
  
    var output : SignUpInteractorOutput!
    var worker : API!
    
    func addUser(formular: inout [String : String]) {
        worker = API.instance
        worker.addAdmin(formular: &formular)
        output.userMayBeHadded()
    }
    
    func createAccount(email: String, password: String) {
        worker = API.instance
        output.accountMayBecreated()
        worker.createAdminAccount(email: email, password: password)
    }
}
