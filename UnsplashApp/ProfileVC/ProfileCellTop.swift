//
//  ProfileCellTop.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 16.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//
protocol ActionManagerForProfileCellTop: class {
    func ButtonAction(cell: ProfileCellTop, tag: Int)
}

import UIKit

class ProfileCellTop: UICollectionViewCell {
    
    static let reuseId = "topProfileCell"
    
    private let avatarImageView = UIImageView()
    private let followButton = UIButton(type: .system)
    private let nameLabel = UILabel()
    private let titleLabel = UILabel()
    
    let photosButton = UIButton(type: .system)
    let likesButton = UIButton(type: .system)
    let collectionsButton = UIButton(type: .system)
    
    weak var delegat: ActionManagerForProfileCellTop?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurator()
        setupElements()
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurator() {
        nameLabel.text = "Edward Nolan"
        titleLabel.text = "Photography lover from 8 years"
        photosButton.setTitle("8 Pgotos", for: .normal)
        likesButton.setTitle("176 Likes", for: .normal)
        collectionsButton.setTitle("6 Collections", for: .normal)
    }
}

//MARK: Private func
extension ProfileCellTop {
    
    private func setupElements() {
        
        nameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        
        photosButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        likesButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        collectionsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)

        photosButton.tag = 0
        likesButton.tag = 1
        collectionsButton.tag = 2
        
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        avatarImageView.backgroundColor = .brown
        avatarImageView.layer.cornerRadius = 8
        titleLabel.textColor = UIColor(red: 177/255, green: 177/255, blue: 177/255, alpha: 1)
        
        photosButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        likesButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        collectionsButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        
        followButton.tintColor = .white
        followButton.backgroundColor = UIColor(red: 45/255, green: 164/255, blue: 1, alpha: 1)
        
        followButton.setTitle("FOLLOW", for: .normal)
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)

        followButton.layer.cornerRadius = 5
        followButton.layer.shadowColor = UIColor(red: 155/255, green: 211/255, blue: 1, alpha: 0.2).cgColor
        followButton.layer.shadowRadius = 6
        followButton.layer.shadowOpacity = 1
        followButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        photosButton.addTarget(self, action: #selector(labelSwitcher(_:)), for: .touchUpInside)
        likesButton.addTarget(self, action: #selector(labelSwitcher(_:)), for: .touchUpInside)
        collectionsButton.addTarget(self, action: #selector(labelSwitcher(_:)), for: .touchUpInside)
    }
    
    private func setupConstraits() {
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        followButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomStack = UIStackView(arrangedSubviews: [photosButton, likesButton, collectionsButton])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 42
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarImageView)
        addSubview(followButton)
        addSubview(nameLabel)
        addSubview(titleLabel)
        addSubview(bottomStack)
        
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 65),
            avatarImageView.widthAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            followButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            followButton.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 28),
            followButton.widthAnchor.constraint(equalToConstant: 81)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 18)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13)
        ])
    }

    @objc private func  labelSwitcher(_ sender: UIButton) {
        delegat?.ButtonAction(cell: self, tag: sender.tag)
    }
}

