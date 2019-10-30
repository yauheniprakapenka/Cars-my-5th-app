//
//  Constants.swift
//  cars
//
//  Created by yauheni prakapenka on 28/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Storyboard {
        static let authorizeController = "authorizeViewCOntrollerID"
        static let mainViewController = "mainViewControllerID"
    }
    
    struct Error {
        static let userCreationError = "Ошибка создания пользователя"
        static let passwordValidationError = "Password must be at least 6 characters"
    }
    
    struct Color {
        static let redColor = #colorLiteral(red: 1, green: 0, blue: 0.3377115726, alpha: 1)
        static let greenColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    
}
