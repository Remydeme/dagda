//
//  QRCodeConfigurer.swift
//  dagda
//
//  Created by remy DEME on 20/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



extension QRCodeInteractor : QRCodeControllerOutput {
    
}

extension QRCodeController : QRCodePresenterOutput{
    
}

extension QRCodePresenter : QRCodeInteractorOutput{
    
}


class QRCodeConfigure {
    
    private init() {}
    
    
    static let instance = QRCodeConfigure()
    
    
    func configure(controller : QRCodeController){
        
        let interactor = QRCodeInteractor()
        
        let presenter = QRCodePresenter()
        
        interactor.output = presenter
        
        presenter.output = controller
        
        controller.output = interactor
    }
    
}





