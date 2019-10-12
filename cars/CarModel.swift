//
//  CarModel.swift
//  cars
//
//  Created by yauheni prakapenka on 12/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

struct Car {
    let year: String
    let manufacturer: String
    let model: String
    let body: String
    let carImage: UIImage
    
    static func getCars() -> [Car] {
        let data: [Car] = [Car(year: "1995", manufacturer: "BMW", model: "5", body: "E39", carImage: #imageLiteral(resourceName: "bmw-m5-e39-8")),
        Car(year: "2010", manufacturer: "Nissan", model: "Juke", body: "B", carImage: #imageLiteral(resourceName: "nissan-juke")),
        Car(year: "1973", manufacturer: "Volkswagen", model: "Beetle", body: "1303", carImage: #imageLiteral(resourceName: "volkswagen type 1"))]
        
        return data
    }
    
}
