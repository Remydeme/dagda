//
//  Description.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit

class Description {
    var id : String = ""
    var lastModification : String = ""
    var note : String = ""
    var room : String = ""
    var valided : String = ""
    var writtenBy : String = ""
    var description : String = ""
    var dico = [String:String]()

   
    
    
    func dictionary() -> [String:String]{
        dico = ["id":id, "description":description,"lastModification":lastModification, "note":note, "room":room, "valided":valided, "writtenBy":writtenBy]
        return dico
    }
    
    
//    func setDescption (){

//    }
}


