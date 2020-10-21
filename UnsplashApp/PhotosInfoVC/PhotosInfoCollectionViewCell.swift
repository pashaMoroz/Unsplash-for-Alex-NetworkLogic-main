//
//  PhotosInfoCollectionViewCell.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 22.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//
protocol HeartButtonProtocol: class {
    func heartButtonPressed(cell: PhotosInfoCollectionViewCell)
}

import UIKit

class PhotosInfoCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "infoCell"
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    let heartButton = UIButton()
    var isLiked = false
    
    weak var delegate: HeartButtonProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
        configurator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurator() {
        nameLabel.text = "Edward Nolan"
        heartButton.setImage(#imageLiteral(resourceName: "Heart_Liked-gray"), for: .normal)
        infoLabel.text =  "449 Likes - 2,289,890 Views - 13,089 Downloads"
    }
}

// MARK: Private methods
extension PhotosInfoCollectionViewCell {
    private func setupElements() {
        nameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        infoLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        
        infoLabel.textColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
        
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 5
    
        heartButton.setImage(#imageLiteral(resourceName: "Heart_Liked-gray"), for: .normal)
        
        heartButton.addTarget(self, action: #selector(heartPressed), for: .touchUpInside)
    }
    
    @objc private func heartPressed() {
        isLiked = isLiked ? false : true
        delegate?.heartButtonPressed(cell: self)
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(heartButton)
        addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 444)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            heartButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            heartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 18),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ])
    }
}
