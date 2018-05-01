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
    func downloadVideoDescription(roomName: String)
}


protocol QRCodeInteractorOutput {
    func mayHaveBeenLoadedDescription()
    func mayHaveBeenLoadedVideo()
}


class QRCodeInteractor : QRCodeInteractorInput{

    
    var output : QRCodeInteractorOutput!
    var worker : API!
    
    func fetchDescriptionIfExist(room: String)  {
        worker = API.instance
        output.mayHaveBeenLoadedDescription()
        worker.roomDescriptionExists(room: room)
    }
    
    func downloadVideoDescription(roomName: String) {
        worker = API.instance
        output.mayHaveBeenLoadedVideo()
       // worker.downloadVideo(name: roomName)
    }
    
}
