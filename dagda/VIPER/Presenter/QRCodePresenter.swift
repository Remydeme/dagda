//
//  QRCodePresenter.swift
//  dagda
//
//  Created by remy DEME on 20/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



protocol QRCodePresenterInput {
    func presentDescription(description: [String:AnyObject]?)
}

protocol QRCodePresenterOutput {
    func displayDescription(description: [String : AnyObject]?)
    func displayAddDescription()
}


class QRCodePresenter : QRCodePresenterInput{

    var output : QRCodePresenterOutput!
    
    func presentDescription(description: [String : AnyObject]?) {
        if description != nil {
            output.displayAddDescription()
        }
        else {
            output.displayDescription(description: description)
        }
    }
}
