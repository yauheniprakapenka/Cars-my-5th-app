//
//  AuthorizationViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 26/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit
import LocalAuthentication
import Firebase
import FirebaseAuth

class AuthorizationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var secureCodeTextField: UITextField!
    @IBOutlet weak var leftCarConstraint: NSLayoutConstraint!
    @IBOutlet weak var trafficLightImageView: UIImageView!
    @IBOutlet weak var helloTextStackView: UIStackView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var biometricView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secureCodeTextField.delegate = self
        
        secureCodeTextField.alpha = 0
        enterButton.alpha = 0
        biometricView.alpha = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        animateCarLeftConstraint()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: "kitty@mail.ru", password: "12345678") { (result, err) in
            if err != nil {
                print("Ошибка создания пользователя")
            } else {
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["firstname" : "Tom", "lastname" : "Jones", "uid" : result!.user.uid]) { (error) in
                    if error != nil {
                        print("Ошибка сохранения пользователя")
                    }
                    print("Пользователь успешно создан")
                }
            }
        }
//FIXME: - Реализовать поля на UI и передавать их
        
//        guard let text = secureCodeTextField.text, text == "1111" else  {
//            print("Код авторизации НЕ верный")
//            secureCodeTextField.shake()
//            secureCodeTextField.textColor = .red
//            return
//        }
//        print("Код авторизации верный")
//        presentMainVC()
    }
    
    @IBAction func biometricButtonTapped(_ sender: UIButton) {
        authenticationWithTouchID()
    }
    
    // Валидация на 4 символа
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        secureCodeTextField.textColor = .black
        guard let text = secureCodeTextField.text else {
            return true
        }
        
        let newLength = text.count + string.count - range.length
        return newLength < 5
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let keyboardFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + keyboardFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height, right: 0)
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    private func animateCarLeftConstraint() {
        UIView.animate(withDuration: 5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
            _ = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { (Timer) in
                self.trafficLightImageView.image = UIImage(named: "Светофор-красный")
            }
            
            _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (Timer) in
                UIView.animate(withDuration: 1.3) {
                    self.secureCodeTextField.alpha = 1
                    self.enterButton.alpha = 1
                }
            }
            
            _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (Timer) in
                UIView.animate(withDuration: 1.3) {
                    self.biometricView.alpha = 1
                }
            }
            
            self.leftCarConstraint.constant = (UIScreen.main.bounds.width / 2) - 140
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

        var authorizationError: NSError?
        let reason = "Authentication required to access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                if success {
                    print("Авторизация по биометрии успешна")
                    DispatchQueue.main.sync {
                        self.presentMainVC()
                    }
                } else {
                    print("Авторизация по биометрии НЕ успешна")
                    guard let error = evaluateError else { return }
                    print(error)
                }
            }
        } else {
            guard let error = authorizationError else {
                return
            }
            print(error)
        }
    }
    
    private func presentMainVC() {
        
        UIView.animate(withDuration: 4.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            self.trafficLightImageView.image = UIImage(named: "Светофор-зеленый")
            self.secureCodeTextField.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            self.leftCarConstraint.constant = UIScreen.main.bounds.width + 30
            self.view.layoutIfNeeded()
        }, completion: { (isSuccessful) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.mainViewController)
            self.present(navigationController, animated: true, completion: nil)
        })
    }
    
}
