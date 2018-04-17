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


class API {
    fileprivate let FIREBASE_URL = "https://dagda-9f511.firebaseio.com/"
    private init (){}
    
    static let instance = API()
    
    func fetchRoomDescription(room : String){
        let ref = Database.database().reference(withPath: "description")
        ref.queryOrdered(byChild: "room").queryEqual(toValue: "30").observeSingleEvent(of: .value, with: {(snapshot)   in
           
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
    
    func roomDescriptionExists(room: String) -> Bool{
        var exist = false
        Database.database().reference(withPath: "description").queryOrdered(byChild: "room").queryEqual(toValue: room).observeSingleEvent(of: .value, with: {snapshot in
            let room = snapshot.value
            if (room != nil) {
                exist = true
            }
        })
        return exist
    }
    
    func addDescription(description: Description){
        let ref = Database.database().reference(withPath: "description")
        let refDes = ref.childByAutoId()
        description.id = refDes.key
        refDes.updateChildValues(description.dictionary(), withCompletionBlock: { (error, ref) in
            if error != nil{
                print ((error! as NSError).localizedDescription
                )
            }
            else {
               print ("added")
            }
        })
    }
}
