//
//  ViewController.swift
//  SocialApp
//
//  Created by Ali Can Kayaaslan on 15.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
    }
    @IBAction func signinButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
}

