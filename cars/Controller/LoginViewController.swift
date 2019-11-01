//
//  LoginViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 30/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.alpha = 0
        activityIndicator.alpha = 0
        
        self.hideKeyboard()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        resultLabel.alpha = 0
        
        guard CheckInternet.Connection() else {
            showAlert(title: "Нет связи с сервером", message: "Проверьте подключение к интернету и повторите снова")
            return
        }
        
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        loginButton.alpha = 0
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                self.loginButton.alpha = 1
                self.activityIndicator.alpha = 0
                self.activityIndicator.stopAnimating()
                
                self.resultLabel.alpha = 1
                self.resultLabel.textColor = Constants.Color.redColor
                self.resultLabel.text = "\(error!.localizedDescription)"
                print("\(error!.localizedDescription)")
                
                
            } else {
                self.loginButton.alpha = 0
                self.resultLabel.alpha = 1
                self.activityIndicator.alpha = 0
                self.activityIndicator.stopAnimating()
                
                self.resultLabel.textColor = Constants.Color.greenColor
                self.resultLabel.text = "Авторизация успешна"
                
                _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (Timer) in
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
        }
    }

}
