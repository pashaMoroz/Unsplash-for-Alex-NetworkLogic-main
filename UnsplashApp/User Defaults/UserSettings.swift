//
//  Extension+UserDefaults.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 25.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

final class UserSettings {

    private enum SettingKey: String {

        case isLoggedIn
        case userToken

        case History
        case Athletics
        case Technology

    }

    static var isLoggedIn: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: SettingKey.isLoggedIn.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.isLoggedIn.rawValue

            if let isLogin = newValue {
                print("value: \(isLogin) was added to key \(key)")
                defaults.set(isLogin, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }

    static var userToken: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingKey.userToken.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.userToken.rawValue

            if let token = newValue {
                print("value: \(token) was added to key \(key)")
                defaults.set(token, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }

    static var History: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingKey.History.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.History.rawValue

            if let history = newValue {
                print("value: \(history) was added to key \(key)")
                defaults.set(history, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }

    static var Athletics: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingKey.Athletics.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.Athletics.rawValue

            if let athletics = newValue {
                print("value: \(athletics) was added to key \(key)")
                defaults.set(athletics, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }

    static var Technology: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingKey.Technology.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.Technology.rawValue

            if let technology = newValue {
                print("value: \(technology) was added to key \(key)")
                defaults.set(technology, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }

}
