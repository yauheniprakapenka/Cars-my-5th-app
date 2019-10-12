//
//  CarModel.swift
//  cars
//
//  Created by yauheni prakapenka on 12/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class CarModel {
    let year: String
    let manufacturer: String
    let model: String
    let body: String
    let carImage: UIImage
    
    init(year: String, manufacturer: String, model: String, body: String, carImage: UIImage) {
        self.year = year
        self.manufacturer = manufacturer
        self.model = model
        self.body = body
        self.carImage = carImage
    }
    
}
