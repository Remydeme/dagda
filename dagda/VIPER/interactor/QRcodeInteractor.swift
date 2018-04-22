//
//  QRcodeInteractor.swift
//  dagda
//
//  Created by remy DEME on 19/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation


protocol QRCodeInteractorInput {
    func fetchDescriptionIfExist(room: String)
}


protocol QRCodeInteractorOutput {
    func presentDescription(description: [String:AnyObject]?)
}


class QRCodeInteractor : QRCodeInteractorInput{
    
    var output : QRCodeInteractorOutput!
    var worker : API!
    
    func fetchDescriptionIfExist(room: String)  {
        worker = API.instance
        worker.roomDescriptionExists(room: room)
        output.presentDescription(description: worker.data)
    }
}
