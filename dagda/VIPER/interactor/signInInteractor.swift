//
//  File.swift
//  dagda
//
//  Created by remy DEME on 27/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



protocol SignInInteractorInput {
    func connect(email: String, password: String)
}

protocol SignInInteractorOutput {
    func mayHaveBeenConnected()
}


class SignInInteractor : SignInInteractorInput{
    
    var output : SignInInteractorOutput!
    var worker : API!
    
    func connect(email: String, password: String) {
        worker = API.instance
        output.mayHaveBeenConnected()
        worker.signIn(email: email, password: password)
    }
}

