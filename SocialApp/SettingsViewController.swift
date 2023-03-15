//
//  SettingsViewController.swift
//  SocialApp
//
//  Created by Ali Can Kayaaslan on 15.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseStorage

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            performSegue(withIdentifier: "toViewController", sender: nil)
            
        } catch {
            print("Error!")
        }
    }
    
}
