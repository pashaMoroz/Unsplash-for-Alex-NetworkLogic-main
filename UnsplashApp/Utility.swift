//
//  Utility.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 24.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

extension URL {
    var queryPairs : [String : String] {
        var results = [String: String]()
        let pairs  = self.query?.components(separatedBy: CharacterSet(charactersIn: "&")) ?? []
        for pair in pairs {
            let kv = pair.components(separatedBy: CharacterSet(charactersIn: "="))
            results.updateValue(kv[1], forKey: kv[0])
        }
        return results
    }
}
