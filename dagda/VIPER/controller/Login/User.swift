//
//  User.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


class User {
    
    public private(set) var name : String = ""
    public private(set) var id : String = ""
    public private(set) var note : String = ""
    
    private init () {}
    
    static let instance = User()
    
    func configure(name: String, id: String, note : String){
        self.name = name
        self.id = id
        self.note = note
    }
    
}
