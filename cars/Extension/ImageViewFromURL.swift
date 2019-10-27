//
//  UIImageView.swift
//  cars
//
//  Created by yauheni prakapenka on 13/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

// Установить изображение для imageView по URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
