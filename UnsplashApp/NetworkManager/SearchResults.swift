//
//  SearchResults.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 25.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: URLKing?


    struct URLKing: Decodable {
        let raw, full, regular, small, thumb: String?
    }

//    enum URLKing: String {
//        case raw
//        case full
//        case regular
//        case small
//        case thumb
//    }
}
