//
//  worker.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import Firebase


let existNotification = "dagda.notification.exist.notification"

class API {
    fileprivate let FIREBASE_URL = "https://dagda-9f511.firebaseio.com/"
    private init (){}
    
    static let instance = API()
    
    var data : [String:AnyObject]?
    var exist = false 
    
    
    func fetchRoomDescription(room : String){
        let ref = Database.database().reference(withPath: "description")
        ref.queryOrdered(byChild: "room").queryEqual(toValue: "E2004").observeSingleEvent(of: .value, with: {(snapshot)   in
           
            for childSnapshot in snapshot.children {
                print(childSnapshot)
            }
        })
        
    }
    

    func fetchDescriptionNotConfirmed() -> [[String:String]]{
        var array = [[String:String]]()
        let ref = Database.database().reference(withPath: "description")
        ref.queryOrdered(byChild: "valided").queryEqual(toValue: "False").observeSingleEvent(of: .value, with: {(snapshot)   in
            for child in snapshot.children{
                let dico = child as! [String:String]
                print (dico)
              array.append(dico)
            }
        })
        return array
    }
    
    
    // utilise le nom de la salle au lieu d'une valeur random de cle
    
    func updateDescription(description: Description) {
        let ref = Database.database().reference()
        let path = String("description") + "/" + description.room
        let childValue = [path:description.dictionary()]
        ref.updateChildValues(childValue)
    }
    
    func roomDescriptionExists(room: String){
        let ref = Database.database().reference(withPath: "description")
        ref.queryOrdered(byChild: "room").queryEqual(toValue: room).observeSingleEvent(of: .value, with: {(snapshot)   in
            
            let value = snapshot.value
            if (value != nil) {
                self.exist = true
            }
            for element in snapshot.children.allObjects as! [DataSnapshot]{
               self.data = element.value as? [String:AnyObject]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: existNotification), object: nil)
                print (self.data!) // should be removed 
            }
        })
    }
    
    func addDescription(description: Description){
        let ref = Database.database().reference(withPath: "description")
        let refDes = ref.childByAutoId()
        description.id = refDes.key
        refDes.updateChildValues(description.dictionary(), withCompletionBlock: { (error, ref) in
            if error != nil{
                print ((error! as NSError).localizedDescription)
            }
            else {
               print ("added")
            }
        })
    }
}
