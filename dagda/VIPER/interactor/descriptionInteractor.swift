//
//  descriptionInteractor.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


protocol DescriptonInteractorInput {
    func fetchDescription()
    func updateDescription(formular: DescriptionCell)
}

protocol DescriptionInteractorOutput{
    func mayBeLoaded()
}

class DescriptionInteractor : DescriptonInteractorInput{
    
    var output : DescriptionInteractorOutput!
    var worker : API!
    
    
    func fetchDescription() {
        output.mayBeLoaded()
        worker = API.instance
        worker.fetchDescriptionNotConfirmed()
    }
    
    func updateDescription(formular: DescriptionCell) {
        let oldDescription = formular.descriptionModel
        if oldDescription!["description"]! == formular.descriptionInput.text!{
            return
        }
        else{
            
            worker = API.instance
            let description = Description()
            description.room = oldDescription!["room"]!
            description.note = oldDescription!["note"]!
            description.id = oldDescription!["id"]!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: NSDate() as Date)
            description.lastModification = dateString
            description.valided = "True"
            description.writtenBy = User.instance.name
            description.description = formular.descriptionInput.text!
            worker.updateDescription(description: description)
        }
        
    }

}
