//
//  CreateAccountViewController.swift
//  Hoink
//
//  Created by Mike Cameron on 2018-09-06.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var databaseManager = DatabaseManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        guard let nickname = nicknameTextField.text, !nickname.isEmpty else {
            print("empty field")
            return
            //ADD POPUP
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            print("empty field")
            return
            //ADD POPUP
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("empty field")
            return
            //ADD POPUP
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else { return }
            //create new local User object with Auth data. Change later with premade Oinks
            let newUser = User(nickname: nickname, UID: user.uid, createdOinks: nil, receivedOinks: nil, friends: nil)
            // send User data to Firestore
            self.databaseManager.storeNewUser(user: newUser)
            self.performSegue(withIdentifier: "accountCreatedSegue", sender: self)
        }
    }
    
}
