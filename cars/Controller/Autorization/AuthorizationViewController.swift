//
//  AuthorizationViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 26/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit
import LocalAuthentication

protocol AnimateCar {
    func presentMainVC()
}

class AuthorizationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var leftCarConstraint: NSLayoutConstraint!
    @IBOutlet weak var trafficLightImageView: UIImageView!
    @IBOutlet weak var helloTextStackView: UIStackView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newProfilerButton: UIButton!
    @IBOutlet weak var biometricButton: UIButton!
    
    @IBAction func фываф(_ sender: Any) {
        print("Есть")
        let avatarVC = AvatarViewController()
        avatarVC.modalPresentationStyle = .fullScreen
        present(avatarVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.alpha = 0
        newProfilerButton.alpha = 0
        biometricButton.alpha = 0

        hideKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        animateCarLeftConstraint()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: Constants.Storyboard.LoginViewController) as? SignInViewController else { return }
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func biometricButtonTapped(_ sender: UIButton) {
        authenticationWithTouchID()
    }
    
    private func animateCarLeftConstraint() {
        UIView.animate(withDuration: 5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
            _ = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { (Timer) in
                self.trafficLightImageView.image = UIImage(named: "Светофор-красный")
            }
            
            _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (Timer) in
                UIView.animate(withDuration: 1.1) {
                    self.loginButton.alpha = 1
                }
            }
            
            _ = Timer.scheduledTimer(withTimeInterval: 2.7, repeats: false) { (Timer) in
                UIView.animate(withDuration: 1.1) {
                    self.newProfilerButton.alpha = 1
                }
            }
            
            _ = Timer.scheduledTimer(withTimeInterval: 3.4, repeats: false) { (Timer) in
                UIView.animate(withDuration: 1.1) {
                    self.biometricButton.alpha = 1
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
    
}

extension AuthorizationViewController: AnimateCar {
    func presentMainVC() {
        UIView.animate(withDuration: 4.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            self.trafficLightImageView.image = UIImage(named: "Светофор-зеленый")
            self.leftCarConstraint.constant = UIScreen.main.bounds.width + 30
            self.view.layoutIfNeeded()
        }, completion: { (isSuccessful) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.MainViewController)
            self.present(navigationController, animated: true, completion: nil)
        })
    }
}
