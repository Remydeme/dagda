//
//  DescriptionPresenter.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



protocol DescriptionPresenterInput {
    func mayBeLoaded()
    func updateDesriptionController(index: IndexPath, error: String?)
}

protocol DescriptionPresenterOuput{
    func desccriptionLoaded(descriptions: [[String:AnyObject]])
    func removeCellAfterDelete(index: IndexPath)
    func errorLoading()
}

class DescriptionPresenter : DescriptionPresenterInput{
 
    var controller : DescriptionPresenterOuput!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func mayBeLoaded() {
        NotificationCenter.default.addObserver(self, selector: #selector (DescriptionPresenter.descriptionLoaded(_:)), name: NSNotification.Name(rawValue: decriptionLoadedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (DescriptionPresenter.errorLoading(_:)), name: NSNotification.Name(rawValue: errorDecriptionLoadedNotification), object: nil)

    }
    

    @objc func descriptionLoaded(_ sender: Any) {
        controller.desccriptionLoaded(descriptions: API.instance.descriptionArray)
    }
    
    @objc func errorLoading(_ sender: Any){
        controller.errorLoading()
    }
    
    func updateDesriptionController(index: IndexPath, error: String?) {
        if error == nil {
            controller.removeCellAfterDelete(index: index)
        }
        else {
            print ("error while deleting")
        }
    }
    
    
}
