//
//  AvatarModel.swift
//  cars
//
//  Created by yauheni prakapenka on 04.11.2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

struct AvatarModel {
    var nameAvatar: String
    var image: UIImage
    
    static func getAvatars() -> [AvatarModel] {
        let data: [AvatarModel] = [AvatarModel(nameAvatar: "girl-2", image: #imageLiteral(resourceName: "girl-2")),
                                   AvatarModel(nameAvatar: "boy-1", image: #imageLiteral(resourceName: "boy-1")),
                                   AvatarModel(nameAvatar: "girl-1", image: #imageLiteral(resourceName: "girl-1")),
                                   AvatarModel(nameAvatar: "boy-2", image: #imageLiteral(resourceName: "boy-2"))]
        return data
    }
    
}
