//
//  QRCodePresenter.swift
//  dagda
//
//  Created by remy DEME on 20/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



protocol QRCodePresenterInput {
    func mayHaveBeenLoadedDescription()
}

protocol QRCodePresenterOutput {
    func displayDescription(description: [String : AnyObject]?)
    func displayAddDescription()
}


class QRCodePresenter : QRCodePresenterInput{


    
    var output : QRCodePresenterOutput!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func mayHaveBeenLoadedDescription(){
        NotificationCenter.default.addObserver(self, selector: #selector (loadDescription(_:)), name: NSNotification.Name(rawValue: existNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (errorLoading), name:  NSNotification.Name(rawValue: existNotification), object: nil)
    }
 

    @objc func loadDescription(_ sender: Any){
        output.displayDescription(description: API.instance.description)
    }
    
    @objc func errorLoading(_ sender: Any){
    }
    
}
