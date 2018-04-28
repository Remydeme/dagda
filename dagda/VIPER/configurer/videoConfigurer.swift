//
//  videoConfigurer.swift
//  dagda
//
//  Created by remy DEME on 28/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



extension VideoInteractor : VideoControllerOutput {
    
}

extension VideoPresenter : VideoInteractorOutput {
    
}

extension VideoController : VideoPresenterOutput  {
    
}


class VideoConfigurer {
   
    private init(){}
    
    static let instance = VideoConfigurer()
    
    func configure(controller : VideoController){
        let interactor = VideoInteractor()
        
        let presenter = VideoPresenter()
        
        interactor.output = presenter
        
        presenter.controller = controller
        
        controller.interactor = interactor
    }
}





