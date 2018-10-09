//
//  LogInViewController.swift
//  Hoink
//
//  Created by Mike Cameron on 2018-09-06.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        
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
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            self.performSegue(withIdentifier: "loggedInSegue", sender: self)
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "createAccountSegue", sender: self)
    }
    
}
