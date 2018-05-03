//
//  editDescriptionPresenter.swift
//  dagda
//
//  Created by remy DEME on 28/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation

protocol EditDescriptionPresenterInput {
    func mayUploadVideo()
    func mayUploadDescription()
    func mayHaveLoadedRoomDescription()
}


protocol EditDescriptionPresenterOutput {
    func videoUploaded(state: Bool)
    func descriptionUploaded(state: Bool)
    func roomInfoDownloaded(description: String, exist: Bool)
}

class EditDescriptionPresenter : EditDescriptionPresenterInput{
   
    var controller : EditDescriptionPresenterOutput!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func cleanObserver(){
        NotificationCenter.default.removeObserver(self) // call this function here beacause the Notificcation center is not clean after each call
    }
    
    func mayUploadVideo() {
        NotificationCenter.default.addObserver(self, selector: #selector (videoUploaded(_:)), name: NSNotification.Name(rawValue: videoPosted), object: nil)
    }
    
    func mayUploadDescription() {
        cleanObserver()
        NotificationCenter.default.addObserver(self, selector: #selector (descriptionUploaded(_:)), name: NSNotification.Name(rawValue: descriptionAdded), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (failedDescriptionAdded(_:)), name: NSNotification.Name(rawValue: descriptionNotAdded), object: nil)
    }
    
    @objc func failedDescriptionAdded(_ sender: Any){
        controller.descriptionUploaded(state: false)
    }
    
    @objc func descriptionUploaded(_ sender: Any){
        controller.descriptionUploaded(state: true)
    }
    
    @objc func videoNotUploaded(_ sender: Any){
        controller.videoUploaded(state: true)
    }
    
    @objc func videoUploaded(_ sender: Any){
        controller.videoUploaded(state: true)
    }
    
    func mayHaveLoadedRoomDescription(){
        NotificationCenter.default.addObserver(self, selector: #selector (descriptionLoaded(_:)), name: NSNotification.Name(rawValue: existNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (descriptionNotLoaded(_:)), name:  NSNotification.Name(rawValue: notExistNotification), object: nil)
    }
    
    @objc func descriptionLoaded(_ sender: Any){
        let description = API.instance.description!["description"] as! String
        controller.roomInfoDownloaded(description: description, exist: true)
    }
    
    @objc func descriptionNotLoaded(_ sender: Any){
        controller.roomInfoDownloaded(description: "", exist: false)
    }
    
}















