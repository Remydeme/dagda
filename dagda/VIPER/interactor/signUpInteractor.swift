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
}

protocol SignUpInteractorOutput {
    func userMayBeHadded()
}


class SignUpInteractor : SignUpInteractorInput{
  
    var output : SignUpInteractorOutput!
    var worker : API!
    
    func addUser(formular: inout [String : String]) {
        worker = API.instance
        worker.addAdmin(formular: &formular)
        output.userMayBeHadded()
    }
}
