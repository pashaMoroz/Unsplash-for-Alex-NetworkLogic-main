//
//  AppDelegate.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 12.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        let tabBarVC = MainTabBarController()
//        window?.rootViewController = tabBarVC

        NetworkManager.sharedManager.setUpWithAppId(appId: Configuration.UnsplashSettings.clientID, secret: Configuration.UnsplashSettings.clientSecret)

        if UserSettings.isLoggedIn {

           // window?.rootViewController = MainTabBarController()
            window?.rootViewController = MainTabBarController()
        } else {

            //window?.rootViewController = LoginViewController()

            window?.rootViewController = LoginViewController()
        }
        return true
    }

}
