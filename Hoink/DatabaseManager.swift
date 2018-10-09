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
    
}
