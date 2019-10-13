//
//  Shake.swift
//  cars
//
//  Created by yauheni prakapenka on 13/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 10, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 10, y: center.y))

        layer.add(animation, forKey: "position")
    }
}
