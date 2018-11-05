//
//  StorageManager.swift
//  Hoink
//
//  Created by Mike Cameron on 2018-10-10.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class StorageManager: NSObject {
    
    var databaseManager = DatabaseManager()
    
    func storeOink(oink: Data, title: String) {

        //get reference to appropriate storage location
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let oinksRef = storageRef.child("oinks/\(title).m4a")
        
        //convert locally stored file into data for upload
        let file = try? Data(contentsOf: self.getFileURL())
        guard let oinkData = file else { return }
        
        let uploadTask = oinksRef.putData(oinkData, metadata: nil) { (storageMetadata, error) in
            oinksRef.downloadURL(completion: { (url, downloadURLError) in
                guard let downloadURL = url else { return }
                let oink = Oink()
                oink.name = title
                oink.createdBy = (UserDefaults.standard.value(forKey: "UserName") as! String)
                oink.downloadURL = downloadURL
                oink.createdDate = Date()
                self.databaseManager.storeOink(oink: oink)
            })
        }
        
        uploadTask.resume()
    }
    
    func getFileURL() -> URL {
        
        let fm = FileManager.default
        let docsURL = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let filePath = docsURL.appendingPathComponent("oink_file.m4a")
        return filePath
    }
}
