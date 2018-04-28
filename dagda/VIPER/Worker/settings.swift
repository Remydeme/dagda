//
//  settings.swift
//  dagda
//
//  Created by remy DEME on 28/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Settings {
    
    private init(){}
    
    static let instance = Settings()
    
    // get the url where we will save the video
    func videoURL() -> URL{
       let manager = FileManager.default
       return manager.urls(for: .documentDirectory, in: .userDomainMask)[0] // return the first URL
        
    }
    
    func tempVideoURL() -> URL {
        let manager = FileManager.default
        return manager.temporaryDirectory
    }
    
    func createDirectory(){
    }
    
    // default settings save
    func saveSetting(name: String, value: Any){
        UserDefaults.standard.set(value, forKey: name)
    }
    
    func deleteFile (url: URL){
        let manager = FileManager.default
        if (manager.fileExists(atPath: url.absoluteString) == true) {
            do {
                try manager.removeItem(at: url)
            }catch let err {
                print(err.localizedDescription)
            }
        }
        
    }
}
