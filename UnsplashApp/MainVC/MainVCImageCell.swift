//
//  MainVCImageCell.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 15.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit
import SDWebImage

class MainVCImageCell: UICollectionViewCell {
    
    static let reuseId = "mainCell"
    
    //   private let imageView = UIImageView()
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //label.text = "1"
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            label.topAnchor.constraint(equalTo: imageView.topAnchor),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurator(with url: String) {

        imageView.sd_setImage(with: URL(string: url))
    }

    let photoImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       imageView.contentMode = .scaleAspectFill
       return imageView
   }()
    
//    var unsplashPhoto: UnsplashPhoto! {
//        didSet {
//            let photoUrl = unsplashPhoto.urls["regular"]
//            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
//            photoImageView.sd_setImage(with: url, completed: nil)
//
//        }
//    }
}
