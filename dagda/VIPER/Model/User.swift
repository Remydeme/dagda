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
    
    public  var name : String = ""
    public  var id : String = ""
    public  var note : String = ""
    public  var firstname : String = ""
    public private(set) var connected = false
    public private(set) var firstConnection : Bool = true
    var email = ""
    var function = ""
    var score = ""
    var birth = ""
    var pseudo = ""
    public private(set) var read : Bool = false
    
    private init () {
//        fullName = UserDefaults.standard.object(forKey: "pseudo") as! String
//        name = UserDefaults.standard.object(forKey: "name") as! String
//        firstConnection = UserDefaults.standard.bool(forKey: "firstConnection")
    }
    
    static let instance = User()
    
    func configure(name: String, id: String, note : String){
        self.name = name
        self.id = id
        self.note = note
    }
    
    
    func setId(id:String){
        self.id = id
    }
    
    func connect(){
        connected = true
    }
    
    func setRead(){
        read = true
    }
    
    func clearRead(){
        read = false
    }
    
    func disconnect(){
        connected = false
    }
    
}
