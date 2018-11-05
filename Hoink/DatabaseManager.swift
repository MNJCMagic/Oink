//
//  DatabaseManager.swift
//  Hoink
//
//  Created by Mike Cameron on 2018-09-07.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class DatabaseManager: NSObject {
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    
    func storeNewUser(user: User) {
        
        let userData: [String: Any] = [
            "nickname": user.nickname!,
            "UID": user.UID!
        ]
        db.collection("users").document(user.UID!).setData(userData) { (error) in
            if let error = error {
                print("error writing doc: \(error.localizedDescription)")
            } else {
                print("user \(user.UID!) added to firestore")
            }
        }
    }
    
    func storeOink(oink: Oink) {
        
        let uid = UserDefaults.standard.value(forKey: "UID") as! String

        db.collection("users").document("\(uid)").collection("createdOinks").addDocument(data: [
            "name": "\(String(describing: oink.name))",
            "createdBy": "\(String(describing: oink.createdBy))",
            "url": oink.downloadURL!,
            "createdDate": oink.createdDate!
        ]) { (error) in
            if let error = error {
                print("Error adding Oink: \(error)")
            } else {
                print("oink added")
            }
        }
    }
    
}
