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
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (Timer) in
            self.getUser()
        })
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        showSignoutAlert()
    }
    
    @IBAction func avatarButtonTapped(_ sender: Any) {
        print("Есть")
        let avatarVC = AvatarViewController()
        avatarVC.modalPresentationStyle = .fullScreen
        present(avatarVC, animated: true)
        
        print("""
        \nСейчас в константе содержится:
        name: \(Constants.UserInfo.Name)
        email: \(Constants.UserInfo.Email)
        uid: \(Constants.UserInfo.UID)
        avatar: \(Constants.UserInfo.Avatar)
        """)
    }
    
    private func getUser() {
        Firestore.firestore().collection("users").document("\(Constants.UserInfo.Email)").getDocument { document, error in
            if let document = document {
                let model = try! FirestoreDecoder().decode(FirebaseUserModel.self, from: document.data()!)
                
                print("\nProfile Information:\nname: \(model.name)\nemail: \(model.email)\nuid: \(model.uid)\navatar: \(model.avatar)")
                
                Constants.UserInfo.Name = "\(model.name)"
                Constants.UserInfo.Email = "\(model.email)"
                Constants.UserInfo.UID = "\(model.uid)"
                Constants.UserInfo.Avatar = "\(model.avatar)"
                
                self.emailLabel.text = "\(Constants.UserInfo.Email)"
                self.nameLabel.text = "\(Constants.UserInfo.Name)"
                
                self.avatarImageView.image = UIImage(named: "\(Constants.UserInfo.Avatar)")
                
                self.tableView.reloadData()
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
