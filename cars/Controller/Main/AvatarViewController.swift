//
//  AvatarViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 04.11.2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

struct AvatarModel {
    var image: UIImage
}

class AvatarViewController: UIViewController {
    
    let data = [AvatarModel(image: #imageLiteral(resourceName: "girl-2")),
                AvatarModel(image: #imageLiteral(resourceName: "boy-1")),
                AvatarModel(image: #imageLiteral(resourceName: "girl-1")),
                AvatarModel(image: #imageLiteral(resourceName: "boy-2"))]

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let backButton: UIButton = {
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 20, y: 60, width: 100, height: 40)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 13
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitle("Назад", for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(backButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
//
//        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
//        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
//        backButton.widthAnchor.constraint(equalToConstant: 400).isActive = true
//        backButton.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}

extension AvatarViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

class CustomCell: UICollectionViewCell {
    
    var data: AvatarModel? {
        didSet {
            guard let data = data  else { return }
            bg.image = data.image
        }
    }
    
    fileprivate let bg: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "girl-2")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
