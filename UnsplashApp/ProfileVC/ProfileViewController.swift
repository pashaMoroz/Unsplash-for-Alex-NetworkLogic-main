//
//  ProfileViewController.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 15.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let sections: [MainVCSection] = [MainVCSection(type: "first", id: 0, items: [
        MainVCItems(imagePath: "")]),
                                     MainVCSection(type: "second", id: 1, items: [
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: ""),
                                        MainVCItems(imagePath: "")
                                     ])]
    
    // Массив для тестирования водопад layout с разным соотношением сторон. Создаем массив соотношений. height /  width = x - массив иксов. Затем высоту будем задавать отностительно ширины - height = x * width
    let rateArr = [1,1.2,1.5,0.5,0.9,0.5,1,1,1.3,1.3,1.2, 0.5]
    
    var dataSource: UICollectionViewDiffableDataSource<MainVCSection, MainVCItems>?
    var currentSnapshot: NSDiffableDataSourceSnapshot<MainVCSection, MainVCItems>?
    var collectionView: UICollectionView!

    private let networkingDataFetcher = HTTPNetworkingDataFetcher()
    
    private var collums = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "@NolanEd"     
        createCollectionView()

        networkingDataFetcher.fetchMyProfile { (result) in
            print(result)
        }
    }
}

//MARK: Private func
extension ProfileViewController {
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        
        collectionView.register(ProfileCellTop.self, forCellWithReuseIdentifier: ProfileCellTop.reuseId)
        
        collectionView.register(MainVCImageCell.self, forCellWithReuseIdentifier: MainVCImageCell.reuseId)
        
        view.addSubview(collectionView)
        createDataSource()
        reloadData()
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MainVCSection, MainVCItems>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case "first":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCellTop.reuseId, for: indexPath) as! ProfileCellTop
                cell.delegat = self
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCImageCell.reuseId, for: indexPath) as! MainVCImageCell
                
                cell.imageView.backgroundColor = indexPath.item % 2 == 0 ? .red : .gray
                cell.label.text = "\(indexPath.item)"
                return cell
            }
        })
    }
    
    private func reloadData() {
        currentSnapshot = NSDiffableDataSourceSnapshot<MainVCSection, MainVCItems>()
        currentSnapshot?.appendSections(sections)
        
        for section in sections {
            currentSnapshot?.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(currentSnapshot!)
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (someNumber, layoutEnviroment) -> NSCollectionLayoutSection? in
            let section = self.sections[someNumber]
            
            switch section.type {
            case "first": return self.createTopSection()
            default:
                return self.createwaterfallSection()
            }
        }
        return layout
    }
    
    private func createTopSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(174))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 33, leading: 41, bottom: 0, trailing: 38)
        return section
    }
    
    private func createwaterfallSection() -> NSCollectionLayoutSection {
        if collums == 2 {
        // Random Item Creation
        var leftArr = 0.0
        var rightArr = 0.0
        var leftGroupItem = [NSCollectionLayoutItem]()
        var rightGroupItem = [NSCollectionLayoutItem]()
        
        for (index, value) in rateArr.enumerated() {
            if index % 2 == 0 {
                leftArr += value
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(CGFloat(value))))
                item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
                leftGroupItem.append(item)
            } else {
                rightArr += value
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(CGFloat(value))))
                item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
                rightGroupItem.append(item)
            }
        }
        
        // Standart Item Creation
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(117))
        let bigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(213))
        
        let smallItemLeft = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItemLeft.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
        let bigItemLeft = NSCollectionLayoutItem(layoutSize: bigItemSize)
        bigItemLeft.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
        
        let smallItemRight = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItemRight.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
        let bigItemRight = NSCollectionLayoutItem(layoutSize: bigItemSize)
        bigItemRight.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 0)
        
        //Standart WaterFall Group
        let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitems: [smallItemLeft, bigItemLeft])
        leftGroup.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitems: [bigItemRight, smallItemRight])
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(330))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [leftGroup, rightGroup])
        
        //RANDOM WaterFall Group
        let mainHeight = leftArr > rightArr ? leftArr : rightArr
        let groupSizeWaterFall = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let groupSizeWaterFallMain = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(CGFloat(mainHeight) * 0.5 ))
        let left = NSCollectionLayoutGroup.vertical(layoutSize: groupSizeWaterFall, subitems: leftGroupItem)
        left.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 15)
        let right = NSCollectionLayoutGroup.vertical(layoutSize: groupSizeWaterFall, subitems: rightGroupItem)
        let groupWaterFall = NSCollectionLayoutGroup.horizontal(layoutSize: groupSizeWaterFallMain, subitems: [left, right])
       
        //SECTION
        let section = NSCollectionLayoutSection(group: groupWaterFall)
      //  let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 24, leading: 20, bottom: 0, trailing: 20)
            return section } else {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                   let item = NSCollectionLayoutItem(layoutSize: itemSize)
                   item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 13, trailing: 0)
                   
                   let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(166))
                   let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: collums)
                   group.interItemSpacing = .fixed(CGFloat(7))
                   
                   let section = NSCollectionLayoutSection(group: group)
                   section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 20, bottom: 0, trailing: 20)
                   
                   return section
        }
    }
}

extension ProfileViewController: ActionManagerForProfileCellTop {
    
    func ButtonAction(cell: ProfileCellTop, tag: Int) {
        switch tag {
        case 0:
            cell.photosButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell.likesButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            cell.collectionsButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            collums = 2
            dataSource?.apply(currentSnapshot!)
        case 1:
            cell.photosButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            cell.likesButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell.collectionsButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            collums = 1
            dataSource?.apply(currentSnapshot!)
        default:
            cell.photosButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            cell.likesButton.tintColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
            cell.collectionsButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            collums = 1
            dataSource?.apply(currentSnapshot!)
        }
    }
}
