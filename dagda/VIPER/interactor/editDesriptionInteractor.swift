//
//  editDesriptionInteractor.swift
//  dagda
//
//  Created by remy DEME on 28/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation


protocol EditDescriptionInteractorInput {
    func uploadVideo(path: URL, name: String)
    func uploadDescription(room: String, description: String)
    func fetchInformation(room: String)
}

protocol EditDescriptionInteractorOutput {
    func mayUploadVideo()
    func mayUploadDescription()
    func mayHaveLoadedRoomDescription()
}


class EditDescriptionInteractor : EditDescriptionInteractorInput{

    
   
    let worker = API.instance
    var output : EditDescriptionInteractorOutput!
    
    func uploadVideo(path: URL, name: String) {
        output.mayUploadVideo()
        worker.uploadVideo(name: name, url: path)
    }
    
    func fetchInformation(room: String) {
        worker.loadFilURL(room: room)
        output.mayHaveLoadedRoomDescription()
        worker.roomDescriptionExists(room: room)
    }
    
    func uploadDescription(room: String, description: String) {
        output.mayUploadDescription()
        let descriptionObject = Description()
        descriptionObject.room = room
        descriptionObject.note = "0"
        descriptionObject.id =  room
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: NSDate() as Date)
        descriptionObject.lastModification = dateString
        descriptionObject.valided = "True"
        descriptionObject.writtenBy = User.instance.email
        descriptionObject.description = description
        worker.addDescription(description: descriptionObject)
    }
    
    
}


