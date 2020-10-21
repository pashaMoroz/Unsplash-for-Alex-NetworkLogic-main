//
//  PhotosInfoViewController.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 22.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class PhotosInfoViewController: UIViewController {
    
    let model = [
        PhotoInfoModel(image: UIImage(systemName: "heart")!, name: "Test", like: true, photoInfo: "Test"),
        PhotoInfoModel(image: UIImage(systemName: "heart")!, name: "Test", like: true, photoInfo: "Test"),
        PhotoInfoModel(image: UIImage(systemName: "heart")!, name: "Test", like: true, photoInfo: "Test"),
        PhotoInfoModel(image: UIImage(systemName: "heart")!, name: "Test", like: true, photoInfo: "Test"),
        PhotoInfoModel(image: UIImage(systemName: "heart")!, name: "Test", like: true, photoInfo: "Test")
    ]
    
    enum Section {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, PhotoInfoModel>?
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "@NolanEd"
        createCollectionView()
    }
}

// MARK: Private methods
extension PhotosInfoViewController {
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(PhotosInfoCollectionViewCell.self, forCellWithReuseIdentifier: PhotosInfoCollectionViewCell.reuseId)
        
        view.addSubview(collectionView)
        
        createDataSource()
        reloadData()
        
        collectionView.backgroundColor = .yellow
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(550))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 25, leading: 20, bottom: 0, trailing: 20)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, PhotoInfoModel>(collectionView: collectionView, cellProvider: { (collectionview, indexPath, model) -> UICollectionViewCell? in
        
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: PhotosInfoCollectionViewCell.reuseId, for: indexPath) as? PhotosInfoCollectionViewCell
            cell?.delegate = self
            return cell
        })
    }
    
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, PhotoInfoModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(model)
        dataSource?.apply(snapShot)
    }
}

extension PhotosInfoViewController: HeartButtonProtocol {
    func heartButtonPressed(cell: PhotosInfoCollectionViewCell) {
        if cell.isLiked {
            cell.heartButton.setImage(#imageLiteral(resourceName: "Heart_Liked-red"), for: .normal)
            
        } else {
            cell.heartButton.setImage(#imageLiteral(resourceName: "Heart_Liked-gray"), for: .normal)
        }
    }
}
