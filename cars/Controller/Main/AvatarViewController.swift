//
//  AvatarViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 04.11.2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

struct AvatarModel {
    var avatar: String
    var image: UIImage
}

class AvatarViewController: UIViewController {
    
    let avatarData = [AvatarModel(avatar: "0", image: #imageLiteral(resourceName: "girl-2")),
                      AvatarModel(avatar: "1", image: #imageLiteral(resourceName: "boy-1")),
                      AvatarModel(avatar: "2", image: #imageLiteral(resourceName: "girl-1")),
                      AvatarModel(avatar: "3", image: #imageLiteral(resourceName: "boy-2"))]

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let selectButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 13
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitle("Выбрать", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleSelect() {
        print("dsfsadfas")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(selectButton)
        
        setupLayout()
        setupButtonControl()
    }
    
    private func setupLayout() {
        collectionView.backgroundColor = .white
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupButtonControl() {
        NSLayoutConstraint.activate([
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension AvatarViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatarData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.avatarData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .white
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
