//
//  ProfileViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 27/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let profile = ProfileModel.getProfile()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCustomCell", for: indexPath) as! CustomProfileViewCell
        
        cell.userNameLabel?.text = profile[indexPath.row].name
        cell.passwordLabel?.text = profile[indexPath.row].password
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}
