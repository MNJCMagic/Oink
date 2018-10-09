//
//  HomeViewController.swift
//  Hoink
//
//  Created by Mike Cameron on 2018-09-06.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
}
