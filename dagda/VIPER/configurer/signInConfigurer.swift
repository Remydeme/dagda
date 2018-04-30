//
//  signInConfigurer.swift
//  dagda
//
//  Created by remy DEME on 27/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



extension SignInInteractor : SignInControllerOutput{
    
}

extension SignInPresenter : SignInInteractorOutput{

    
}

extension SignIn : SignInPresenterOutput{
    
}



class SignInConfigurer {
    
    private init() {}
    
    static let instance = SignInConfigurer()
    
    func configure(controller : SignIn){
        let signInInteractor = SignInInteractor()
        let presenter = SignInPresenter()
        
        signInInteractor.output = presenter
        
        presenter.controller = controller
        
        controller.interactor = signInInteractor
    }
}
