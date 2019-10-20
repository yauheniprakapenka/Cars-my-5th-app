//
//  UITestHelper.swift
//  carsUITests
//
//  Created by yauheni prakapenka on 20/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class UITestHelper {
    
    // MARK: - Enter Data
    
    func enterDataInTheField(string: String) {
        for char in string {
            let literal = String(char).replacingOccurrences(of: " ", with: "space")
            app.keys[literal].tap()
        }
    }
    
    // MARK: - Tap
    
    func tapOnCoordinate(at xCoordinate: Double, and yCoordinate: Double) {
        let normalized = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))
        coordinate.tap()
    }
    
}
