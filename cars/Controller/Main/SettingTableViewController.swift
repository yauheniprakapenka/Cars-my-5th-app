//
//  SettingTableViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 02/11/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.text = "\(Constants.UserInfo.Email)"
        
        getUser()
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        showSignoutAlert()
    }
    
    private func getUser() {
        Firestore.firestore().collection("users").document("\(Constants.UserInfo.Email)").getDocument { document, error in
            if let document = document {
                let model = try! FirestoreDecoder().decode(FirebaseUserModel.self, from: document.data()!)
                print("\nProfile Information:\nname: \(model.name)\nemail: \(model.email)\nuid: \(model.uid)")
            } else {
                print("Document does not exist")
            }
        }
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
