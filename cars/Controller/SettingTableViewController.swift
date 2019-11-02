//
//  SettingTableViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 02/11/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.text = "\(Constants.userInfo.EmailText)"
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        showSignoutAlert()
    }
    
    private func showSignoutAlert() {
        let alert = UIAlertController(title: "Sign out",
                                      message: "Do you want to leave?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
                                        // cancel action
        }))
        
        alert.addAction(UIAlertAction(title: "Sign out",
                                      style: UIAlertAction.Style.default,
                                      handler: { (_: UIAlertAction!) in
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyboard.instantiateViewController(identifier: Constants.Storyboard.AuthorizationViewController)
                                        self.present(vc, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
