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
let addedNotification = "dagda.notification.added.notification"
let errorAddedNotification = "dagda.notification.error.added.notification"

let decriptionLoadedNotification = "dagda.notification.loaded.notification"
let errorDecriptionLoadedNotification = "dagda.notification.error.loaded.notification"


class API {
    fileprivate let FIREBASE_URL = "https://dagda-9f511.firebaseio.com/"
    private init (){}
    
    static let instance = API()
    
    var data : [String:AnyObject]?
    var descriptionArray : [[String:AnyObject]]!
    var exist = false 
    var added = false
    var error = ""
    
    func fetchRoomDescription(room : String){
        let ref = Database.database().reference(withPath: "description")
        ref.queryOrdered(byChild: "room").queryEqual(toValue: "E2004").observeSingleEvent(of: .value, with: {(snapshot)   in
           
            for childSnapshot in snapshot.children {
                print(childSnapshot)
            }
        })
        
    }
    

    func fetchDescriptionNotConfirmed(){
        descriptionArray = [[String:AnyObject]]()
        let ref = Database.database().reference(withPath: "description")
        ref.queryOrdered(byChild: "valided").queryEqual(toValue: "False").observeSingleEvent(of: .value, with: {(snapshot)   in
            for element in snapshot.children.allObjects as! [DataSnapshot]{
                let data = element.value as? [String:AnyObject]
                self.descriptionArray.append(data!)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: decriptionLoadedNotification), object: nil)
        })
    }
    
    
    
    // utilise le nom de la salle au lieu d'une valeur random de cle
    
    func updateDescription(description: Description) {
        let ref = Database.database().reference(withPath: "description").child(description.room)
        ref.updateChildValues(description.dictionary())
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
        let ref = Database.database().reference(withPath: "description").child(description.room)
        ref.updateChildValues(description.dictionary(), withCompletionBlock: { (error, ref) in
            if error != nil{
                print ((error! as NSError).localizedDescription)
            }
            else {
               print ("added")
            }
        })
    }
    
    
    func addAdmin(formular: inout [String:String]){
        // clear added
        self.added = false
        let ref = Database.database().reference(withPath: "admin")
        let child = ref.childByAutoId()
        let id = child.key
        formular["id"] = id
        child.updateChildValues(formular, withCompletionBlock: { (error, ref) in
            if error != nil{
                self.error = (error?.localizedDescription)!
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: errorAddedNotification), object: nil)
            }
            else {
                self.added = true
                self.error = "Admin had been added"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: addedNotification), object: nil)
            }
        })
    }
    
    
    func signOut (){
        do {
            try (Auth.auth().signOut())
        }
        catch let err {
            print (err.localizedDescription)
        }
    }
    
}
