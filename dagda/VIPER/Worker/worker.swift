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
let notExistNotification = "dagda.notification.not.exist.notification"

let fetchAdminData = "dagda.notification.fetch.admin.data.success.notification"
let fetchAdminDataError = "dagda.notification.fetch.data.error.notification"

let addedNotification = "dagda.notification.added.notification"
let errorAddedNotification = "dagda.notification.error.added.notification"

let decriptionLoadedNotification = "dagda.notification.loaded.notification"
let errorDecriptionLoadedNotification = "dagda.notification.error.loaded.notification"

let deleteNotification = "dagda.notification.delete.notification"
let deleteErrorNotification = "dagda.notification.error.deleting.notification"

let descriptionLoaeded = "dagda.notification.loaded.notification"
let descriptionLoadedError = "dagda.notification.error.loaded.notification"


let signInSuccess = "dagda.notification.sign.in.success.notification"
let signInError = "dagda.notification.sign.in.error.notification"


let adminAdded = "dagda.notification.admin.added.notification"
let adminAddFailed = "dagda.notification.admin.added.failed.notification"

let videoPosted = "dagda.notification.video.posted.notification"


let descriptionAdded = "dagda.notification.add.desription.notification"
let descriptionNotAdded = "dagda.notification.not.add.desription.notification"

class API {
    fileprivate let FIREBASE_URL = "https://dagda-9f511.firebaseio.com/"
    private init (){}
    
    static let instance = API()
    
    var description : [String:AnyObject]? // Qrcode informations description
    var descriptionArray : [[String:AnyObject]]!
    var adminData : [String:AnyObject]!
    var exist = false 
    var added = false
    var error = ""
    var accountCreationError = ""
    var deletingError : String?
    var tryToGet : Bool = false

    

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
    
    
    
    /* utilise le nom de la salle au lieu d'une valeur random de cle*/
    
    func confirmDescription(description: Description, id: String) {
        deleteDescription(room: id)
        let ref = Database.database().reference(withPath: "description").child(description.room)
        ref.updateChildValues(description.dictionary())
    }
    
    
    /**
     this function should use a unique id that is the description key
     and have the room value equal to the room that we want to update 
     */
    
    func userUpdateDescription(description: Description) {
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
    
    
    // fetch the description of a specific room using his ID
    func roomDescriptionExists(room: String){
        self.description = nil
        let ref = Database.database().reference(withPath: "description")
        ref.queryOrdered(byChild: "room").queryEqual(toValue: room).observeSingleEvent(of: .value, with: {(snapshot)   in
            let value = snapshot.value
            if (value != nil) {
                self.exist = true
            }
            if  snapshot.hasChildren() == false {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notExistNotification), object: nil)
                self.tryToGet = false // clear
            }
            for element in snapshot.children.allObjects as! [DataSnapshot] {
               self.description = element.value as? [String:AnyObject]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: existNotification), object: nil)
                break 
            }
        })
    }
    
    func addDescription(description: Description){
        let ref = Database.database().reference(withPath: "description").child(description.id)
        ref.updateChildValues(description.dictionary(), withCompletionBlock: { (error, ref) in
            if error != nil{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: descriptionNotAdded), object: nil)
            }
            else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: descriptionAdded), object: nil)
            }
        })
    }
    
    func deleteDescription(room: String){
        let ref = Database.database().reference(withPath: "description").child(room)
        ref.removeValue(completionBlock: {(error, ref) in
            if error != nil {
                print ("Something bad happened while deleting element")
                self.deletingError = (error?.localizedDescription)!
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: deleteErrorNotification), object: nil)
            }
            else {
                self.deletingError = nil
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: deleteNotification), object: nil)
            }
            })
    }
    
    func addAdmin(formular: [String:String]){
        // clear added
        self.added = false
        let ref = Database.database().reference(withPath: "admin").childByAutoId()
        let adminFormular = AdminFormular()
        adminFormular.email = formular["email"]!
        adminFormular.firstName = formular["firstname"]!
        adminFormular.id = ref.key
        
        ref.updateChildValues(adminFormular.formular, withCompletionBlock: { (error, ref) in
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
    
    func fetchAdmin(email: String){
        let ref = Database.database().reference(withPath: "admin").queryOrdered(byChild: "email").queryEqual(toValue: email)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
        
            let value = snapshot.value
            if (value == nil) {
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: fetchAdminDataError), object: nil)
            }

            for element in snapshot.children.allObjects as! [DataSnapshot]{
                self.adminData = element.value as? [String:AnyObject]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: fetchAdminData), object: nil)
                break
            }
        
            })
    }
    
    func createAdminAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let err = error {
                self.accountCreationError = err.localizedDescription
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: adminAddFailed), object: nil)
            } else {
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: adminAdded), object: nil)
            }}
        )
    }
    
    
    func uploadVideo(name: String, url: URL){
        let filename = name + ".mp4"
        let ref = Storage.storage().reference().child("video").child(filename)
        ref.putFile(from: url)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: videoPosted), object: nil)
    }
    
    func signOut (){
        do {
            try (Auth.auth().signOut())
        }
        catch let err {
            print (err.localizedDescription)
        }
    }
    
    
    func signIn (email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
            if let err = error {
                print(err.localizedDescription)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: signInError), object: nil)
            }
            else {
                User.instance.connect()
                User.instance.configure(name: (user?.email)!, id: (user?.uid)!, note : "0")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: signInSuccess), object: nil)
            }
        })

    }
    
}
