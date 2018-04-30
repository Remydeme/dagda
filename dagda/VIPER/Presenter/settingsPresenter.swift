//
//  settingsPresenter.swift
//  dagda
//
//  Created by remy DEME on 29/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation


protocol SettingsPresenterInput{
    func mayHaveLoadSettings()
    func mayHaveChangedLastName()
    func mayHaveUpdateEmail()
    func mayHaveUpdatePseudo()
}

protocol SettingsPresenterOutput {
    
}


class SettingsPresenter : SettingsPresenterInput{
    
    var controller : SettingsPresenterOutput!
    
    func mayHaveLoadSettings() {
        
    }
    
    func mayHaveChangedLastName() {
    }
    
    func mayHaveUpdateEmail() {
    }
    
    func mayHaveUpdatePseudo() {
    }
    
    
}
