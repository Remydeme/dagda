//
//  settingsInteractor.swift
//  dagda
//
//  Created by remy DEME on 29/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation


protocol SettingsInteractorInput {
    func fetchSettings(email: String)
    func updateFirstName(value: String)
    func updateLastname(value: String)
    func updateEmail(value: String)
    func updatePseudo(value: String)
}

protocol SettingsInteractorOutput {
    func mayHaveLoadSettings()
    func mayHaveChangedLastName()
    func mayHaveUpdateEmail()
    func mayHaveUpdatePseudo()
    
}

class SettingsInteractor : SettingsInteractorInput{
    
    let worker = API.instance
    
    func fetchSettings(email: String) {
        worker.fetchAdmin(email: email)
    }
    
    func updateFirstName(value: String) {
        
    }
    
    func updateLastname(value: String) {
        
    }
    
    func updateEmail(value: String) {
        
    }
    
    func updatePseudo(value: String) {
        
    }
    

}
