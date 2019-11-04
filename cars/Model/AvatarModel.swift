//
//  AvatarModel.swift
//  cars
//
//  Created by yauheni prakapenka on 04.11.2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

struct AvatarModel {
    var avatar: String
    var image: UIImage
    
    static func getAvatars() -> [AvatarModel] {
        let data: [AvatarModel] = [AvatarModel(avatar: "0", image: #imageLiteral(resourceName: "girl-2")),
                                   AvatarModel(avatar: "1", image: #imageLiteral(resourceName: "boy-1")),
                                   AvatarModel(avatar: "2", image: #imageLiteral(resourceName: "girl-1")),
                                   AvatarModel(avatar: "3", image: #imageLiteral(resourceName: "boy-2"))]
        return data
    }
    
}
