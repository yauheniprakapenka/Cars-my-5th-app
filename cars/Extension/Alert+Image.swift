//
//  Alert+Image.swift
//  cars
//
//  Created by yauheni prakapenka on 31/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 90, width: 240, height: 100))
        imageView.image = #imageLiteral(resourceName: "no-internet2")
        imageView.contentMode = .scaleAspectFit
        alert.view.addSubview(imageView)
        
        let width = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 260)
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // your actions here...
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
