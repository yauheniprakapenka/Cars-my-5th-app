//
//  PresentMainVC.swift
//  cars
//
//  Created by yauheni prakapenka on 27/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class PresentMainVC: UIViewController {
    
    func presentMainVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTableViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewControllerID") as! MainTableViewController
        self.present(mainTableViewController, animated: true, completion: nil)
    }
    
}
