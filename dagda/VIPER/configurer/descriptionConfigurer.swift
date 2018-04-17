//
//  descriptionConfigurer.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation


extension DescriptionPresenter : DescriptionInteractorOutput {
    
}

extension DescriptionController : DescriptionPresenterOuput{

}

extension DescriptionInteractor : DescriptionControllerOutput {
    
}

class DescriptionConfigurer{
    
    private init() {}
    
    static let instance = DescriptionConfigurer()
    
    
    func configure(controller : DescriptionController){
        let interactor = DescriptionInteractor()
        
        let presenter = DescriptionPresenter()
        
        interactor.output = presenter
        
        presenter.controller = controller
        
        controller.output = interactor
    }
    
}
