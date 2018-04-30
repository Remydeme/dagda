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
}


protocol EditDescriptionPresenterOutput {
    func videoUploaded(state: Bool)
    func descriptionUploaded(state: Bool)
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
        cleanObserver()
        
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
    
}
