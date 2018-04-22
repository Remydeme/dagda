//
//  signUpConfigurer.swift
//  dagda
//
//  Created by remy DEME on 21/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation




extension SignUpPresenter : SignUpInteractorOutput{
    
}


extension SignUp : SignUpPresenterOutput{
    
}

extension SignUpInteractor : SignUpControllerOutput{
    
}

class SignUpConfigurer{
    
    
    static let instance = SignUpConfigurer()
    
    func configure (controller : SignUp){
        let interactor = SignUpInteractor()
        
        let presenter = SignUpPresenter()
        
        interactor.output = presenter
        
        presenter.controller = controller 
        
        controller.interactor = interactor
    }
}
