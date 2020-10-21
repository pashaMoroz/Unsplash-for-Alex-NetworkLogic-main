//
//  MainViewController.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 12.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

protocol MainViewControllerUpdateDataDelegate: class {
    func refreshData(idTopic: String)
}

class MainViewController: UIViewController {

    // MARK: - Properties

    var sections: [MainVCSection] = []

    var dataSource: UICollectionViewDiffableDataSource<MainVCSection, MainVCItems>?
    var currentSnapshot: NSDiffableDataSourceSnapshot<MainVCSection, MainVCItems>?

//    var networkDataFetcher = NetworkDataFetcher()
    private let networkingDataFetcher = HTTPNetworkingDataFetcher()
    var photos = [TopicsImagesResult]()
    var searchPhotos = [UnsplashPhoto]()
    
    var collectionView: UICollectionView!

    lazy var searchBar = UISearchBar()

    private var collums = 1
    private var timer: Timer?

    private var selectedImages = [UIImage]()

    // MARK: - View Lifecicle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        setupSearchBar()
        createCollectionView()
        collectionView.delegate = self

        searchBar.delegate = self

        print("UserSettings.userToken - - - -- - - - - -- - --\(UserSettings.userToken!)")

        self.networkingDataFetcher.fetchTopicsIDs(from: [.Athletics, .History, .Technology]) {

            self.networkingDataFetcher.fetchTopicsImages(idTopic: UserSettings.History) { [weak self] (results) in
                guard let results = results else { return }
                self?.photos = results
                self?.collectionView.reloadData()
            }
            self.createCollectionView()
            self.refresh()
        }
    }
}


extension MainViewController {
    private func fetchImagesFromCurrentTopic(idTopic: String) {

    }
}


extension MainViewController: MainViewControllerUpdateDataDelegate {

    func refreshData(idTopic: String) {

        searchBar.text = ""

        self.networkingDataFetcher.fetchTopicsIDs(from: [.Athletics, .History, .Technology]) {

            self.networkingDataFetcher.fetchTopicsImages(idTopic: idTopic) { [weak self] (results) in
                guard let results = results else { return }
                self?.photos = results
                self?.collectionView.reloadData()
            }
            self.refresh()
        }
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            guard let searchText = searchBar.text else { return }

            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in

                self.networkingDataFetcher.fetchImages(searchTerm: searchText) { (result) in

                    switch result {
                    case .success(let fetchedPhotos):
                        self.searchPhotos = fetchedPhotos.results
                       // print("searchPhotos.count", self.searchPhotos.count)
                        self.collectionView.reloadData()
                        self.refresh()
                        self.searchBarSearchButtonClicked(searchBar)
                    case .failure:
                        break
                    }
                }
            })
        }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

// MARK: Setup View
extension MainViewController {

    private func createMainVCItems() -> [MainVCItems] {

        var mainVCItems: [MainVCItems] = []

        for _ in 0...30 {

            mainVCItems.append(MainVCItems(imagePath: ""))
        }
        return mainVCItems
    }

    private func setupSearchBar() {

        self.navigationItem.titleView = searchBar
    }

    private func createCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        
        collectionView.register(MainVCImageCell.self, forCellWithReuseIdentifier: MainVCImageCell.reuseId)
        collectionView.register(MainVCControlCell.self, forCellWithReuseIdentifier: MainVCControlCell.reuseId)


        sections = [MainVCSection(type: "first", id: 0, items:[MainVCItems(imagePath: "")]),
                    MainVCSection(type: "second", id: 1, items: createMainVCItems())]

        view.addSubview(collectionView)
        createDataSource()
        reloadData()
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MainVCSection, MainVCItems>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case "first":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCControlCell.reuseId, for: indexPath) as! MainVCControlCell
                cell.delegat = self
                cell.refreshDelegate = self
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCImageCell.reuseId, for: indexPath) as! MainVCImageCell

                if self.photos.count - 1 > indexPath.item && self.searchBar.text == "" {

                    cell.configurator(with: self.photos[indexPath.item].urls?.regular ?? "")
                }

                if self.searchPhotos.count - 1 > indexPath.item && self.searchBar.text != "" {
                    print(self.searchPhotos[indexPath.item].urls?.regular)
                    cell.configurator(with: self.searchPhotos[indexPath.item].urls?.regular ?? "")
                }
                

                return cell
            }
        })
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (someNumber, layoutEnviroment) -> NSCollectionLayoutSection? in
            let section = self.sections[someNumber]
            switch section.type {
            case "first": return self.createControlSection()
            default:
                return self.createMainSectionGrid2x2()
            }
        }
        return layout
    }

    private func createMainSectionGrid2x2() -> NSCollectionLayoutSection{
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
    
    private func createControlSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(19))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 14, leading: 22, bottom: 25, trailing: 24)
        
        return section
    }
}

// MARK: ChangeCellViewProtocol

extension MainViewController: ChangeCellViewProtocol {

    
    internal func buttonAction(cell: MainVCControlCell, tag: Int) {

        let deselectColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1)
        let grid1x1Image = UIImage(systemName: "rectangle.grid.1x2.fill")
        let grid2x2Image = UIImage(systemName: "rectangle.grid.2x2")

        if tag == 0 {
            cell.oneInRowButton.setImage(grid1x1Image, for: .normal)
            cell.oneInRowButton.tintColor = .black
            
            cell.twoInRowButton.setImage(grid2x2Image, for: .normal)
            cell.twoInRowButton.tintColor = deselectColor
            collums = 1
            
        } else {
            cell.twoInRowButton.setImage(grid2x2Image, for: .normal)
            cell.twoInRowButton.tintColor = .black
            
            cell.oneInRowButton.setImage(grid1x1Image, for: .normal)
            cell.oneInRowButton.tintColor = deselectColor
            collums = 2
        }

        dataSource?.apply(currentSnapshot!)
    }
}

// MARK: UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newViewController = ScrollImageViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}


// MARK: Reload/Refresh UI

extension MainViewController {

    private  func refresh() {
        self.selectedImages.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
    }

    private func reloadData() {
        currentSnapshot = NSDiffableDataSourceSnapshot<MainVCSection, MainVCItems>()

        currentSnapshot?.appendSections(sections)

        for section in sections {
            currentSnapshot?.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(currentSnapshot!)
    }
}
