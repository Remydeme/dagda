//
//  videoInteractor.swift
//  dagda
//
//  Created by remy DEME on 28/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



protocol VideoInteractorInput {
    
}

protocol VideoInteractorOutput {
    
}

class VideoInteractor : VideoInteractorInput {
    
    var output : VideoInteractorOutput!
    var worker : API!
    
    
}

