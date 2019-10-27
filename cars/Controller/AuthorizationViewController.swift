//
//  AuthorizationViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 26/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var secureCodeTextField: UITextField!
    @IBOutlet weak var leftCarConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secureCodeTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        animateCarLeftConstraint()
    }
    
    @IBAction func verifyButtonTapped(_ sender: UIButton) {
        guard let text = secureCodeTextField.text, text == "1111" else  {
            print("Код не верный")
            secureCodeTextField.shake()
            secureCodeTextField.textColor = .red
            return
        }
        
        print("Код верный")
        UIView.animate(withDuration: 2.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            self.leftCarConstraint.constant = UIScreen.main.bounds.width
            self.view.layoutIfNeeded()
        }, completion: { (isSuccessful) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTableViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewControllerID") as! MainTableViewController
            self.present(mainTableViewController, animated: true, completion: nil)
        })
    }
    
    // Не дает ввести больше 4 символов в поле
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        secureCodeTextField.textColor = .black
        guard let text = secureCodeTextField.text else {
            return true
        }
        
        let newLength = text.count + string.count - range.length
        return newLength < 5
    }
    
    private func animateCarLeftConstraint() {
        UIView.animate(withDuration: 5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
            self.leftCarConstraint.constant = (UIScreen.main.bounds.width / 2) - 80
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
