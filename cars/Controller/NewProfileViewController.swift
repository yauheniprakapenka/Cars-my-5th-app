//
//  NewProfileViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 29/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NewProfileViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.alpha = 0
        result.alpha = 0
        self.hideKeyboard()
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        result.alpha = 0
        
        guard let email = emailTextField.text, !email.isEmpty else {
            emailTextField.shake()
            return
        }
        
        guard let login = passwordTextField.text, !login.isEmpty else {
            passwordTextField.shake()
            return
        }
        
        if passwordTextField.text!.count < 6 {
            passwordTextField.shake()
            showErrorMessage(message: "\(Constants.Error.passwordValidationError)")
            return
        }
        
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            firstNameTextField.shake()
            return
        }
        
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
            lastNameTextField.shake()
            return
        }
        
        createButton.alpha = 0
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, err) in
            if err != nil {
                self.activityIndicator.alpha = 0
                self.activityIndicator.stopAnimating()
                self.showErrorMessage(message: "\(Constants.Error.userCreationError)")
                self.createButton.alpha = 1
                print("\(Constants.Error.userCreationError)")
            } else {
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["firstname" : self.firstNameTextField.text!, "lastname" : self.lastNameTextField.text!, "uid" : result!.user.uid]) { (error) in
                    if error != nil {
                        print("Ошибка сохранения пользователя")
                    }
                    print("Пользователь успешно создан")
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    
                    _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { [weak self] (Timer) in
                        self?.result.alpha = 1
                        self?.result.text = "Успешно"
                        self?.result.textColor = .green
                    })
                    
                    _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self] (Timer) in
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let authorizeVC = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.authorizeController)
                        self!.present(authorizeVC, animated: true, completion: nil)
                    })
                    
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showErrorMessage(message: String) {
        result.alpha = 1
        result.text = "\(message)"
        result.textColor = .red
    }
    
}
