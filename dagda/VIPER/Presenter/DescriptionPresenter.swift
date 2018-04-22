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
}

protocol DescriptionPresenterOuput{
    func desccriptionLoaded(descriptions: [[String:AnyObject]])
    func errorLoading()
}

class DescriptionPresenter : DescriptionPresenterInput{
  
    var controller : DescriptionPresenterOuput!

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
}
