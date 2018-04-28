//
//  editDesccriptionConfigurer.swift
//  dagda
//
//  Created by remy DEME on 28/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation

extension EditDescriptionPresenter: EditDescriptionInteractorOutput {
    
}

extension EditDescription : EditDescriptionPresenterOutput {
    
}

extension EditDescriptionInteractor : EditDescriptionControllerOuput {
    
}

class EditDescriptionConfigurer{
    
    private init() {}
    
    static let instance = EditDescriptionConfigurer()
    
    
    func configure(controller : EditDescription){
        let interactor = EditDescriptionInteractor()
        
        let presenter = EditDescriptionPresenter()
        
        interactor.output = presenter
        
        presenter.controller = controller
        
        controller.interactor = interactor
    }
    
}
