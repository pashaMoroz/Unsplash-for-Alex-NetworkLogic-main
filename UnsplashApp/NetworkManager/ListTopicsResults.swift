//
//  ListTopicsResults.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 26.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation


// MARK: - ListTopicsResult
struct ListTopicsResult: Decodable {
    let id, title, slug: String?
    let coverPhoto: CoverPhoto?

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case coverPhoto = "cover_photo"
    }
}

// MARK: - CoverPhoto
struct CoverPhoto: Decodable {
    let urls: Urls?
    let user: User?
}


// MARK: - Urls
struct UrlsImages: Decodable {
    let raw, full, regular, small: String?
}

// MARK: - User
struct UserInfo: Decodable {
    let id, location: String?
    let totalLikes: Int?

    enum CodingKeys: String, CodingKey {
        case id, location
        case totalLikes = "total_likes"
    }
}

typealias ListTopicsResults = [ListTopicsResult]



