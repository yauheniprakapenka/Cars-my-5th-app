//
//  ProfileModel.swift
//  cars
//
//  Created by yauheni prakapenka on 27/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

struct ProfileModel {
    let name: String
    let password: String
    
    static func getProfile() -> [ProfileModel] {
        let data: [ProfileModel] = [ProfileModel(name: "user 1", password: "1111"),
                                    ProfileModel(name: "user 2", password: "2222")]
        
        return data
    }
    
}
