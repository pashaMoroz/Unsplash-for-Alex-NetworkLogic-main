//
//  MainTabBarController.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 22.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .darkGray

        let mainVC = MainViewController()
        let mainVCNav = UINavigationController(rootViewController: mainVC)
        
        let newPostVC = PhotosInfoViewController()
        let newPostVCNav = UINavigationController(rootViewController: newPostVC)
        
        let profileVC = ProfileViewController()
        let profileVCNav = UINavigationController(rootViewController: profileVC)
        
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        newPostVC.tabBarItem.image = UIImage(systemName: "plus")
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        
        viewControllers = [mainVCNav, newPostVCNav, profileVCNav]
    }
}
