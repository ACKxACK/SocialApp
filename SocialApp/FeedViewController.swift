//
//  FeedViewController.swift
//  SocialApp
//
//  Created by Ali Can Kayaaslan on 15.03.2023.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! FeedCell
        cell.emailText.text = "alican@gmail.com"
        cell.commentText.text = "Test comment! 123"
        cell.postImageView.image = UIImage(named: "welcome")
        return cell
    }

}
