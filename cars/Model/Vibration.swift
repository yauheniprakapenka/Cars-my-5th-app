//
//  Vibration.swift
//  cars
//
//  Created by yauheni prakapenka on 13/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class Vibration {
    
    enum VibrationStyle: String {
        case light
        case medium
        case heavy
    }
    
    func makeVibration(style: VibrationStyle) {
        if style == VibrationStyle.light {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            feedbackGenerator.impactOccurred()
        } else if style == VibrationStyle.medium {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.impactOccurred()
        } else if style == VibrationStyle.heavy {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator.impactOccurred()
        }
    }
    
}
