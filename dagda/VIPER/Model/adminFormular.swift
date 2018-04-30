//
//  adminFormular.swift
//  dagda
//
//  Created by remy DEME on 29/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation



class AdminFormular {
    
    var pseudo = "Empty"
    var name = ""
    var firstName = ""
    var email = ""
    var birth = ""
    var id = ""
    var function = "Empty"
    var score = "Emptyx" // ontribution score each time you contribute you win 10 point if you validate something you win 5
    
    var formular : [String:String] {

        set (dico){
            self.formular["family name"] = dico["family name"]
            self.formular["firstname"] = dico["firstname"]
            self.formular["email"] = dico["email"]
            self.formular["password"] = dico["password"]
        }
        get{
            var dico = [String:String]()
            dico["pseudo"] = pseudo
            dico["family name"] = name
            dico["firstname"] = firstName
            dico["email"] = email
            dico["birth"] = birth
            dico["id"] = email
            dico["function"] = function
            return dico
        }
    }
    
    init() {
        
    }
    
    // this function take the password and hash the password
    func savePassewor(password : String){
    }
}
