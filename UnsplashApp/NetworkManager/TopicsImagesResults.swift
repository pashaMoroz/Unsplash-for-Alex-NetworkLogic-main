//
//  TopicsImagesResults.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 27.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

//struct TopicsImagesResult: Decodable {
//    let urls: UrlsTopicsImages?
//}
//
//
//// MARK: - Urls
//struct UrlsTopicsImages: Decodable {
//    let raw, full, regular, small: String?
//}
//
//
//typealias TopicsImagesResults = [TopicsImagesResult]



// MARK: - TopicsImagesResult
struct TopicsImagesResult: Decodable {
    let id: String?
    let likedByUser: Bool?
    let topicsImagesResultDescription: String?
    let user: User?
    let urls: Urls?
    let links: TopicsImagesResultLinks?

    enum CodingKeys: String, CodingKey {
        case id
        case likedByUser = "liked_by_user"
        case topicsImagesResultDescription = "description"
        case user
        case urls, links
    }
}


// MARK: - TopicsImagesResultLinks
struct TopicsImagesResultLinks: Decodable {
    let linksSelf, html, download, downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Urls
struct Urls: Decodable {
    let raw, full, regular, small: String?
    let thumb: String?
}


// MARK: - User
struct User: Decodable {
    let id, username, name: String?
    let portfolioURL: String?
    let bio, location: String?
    let totalLikes, totalPhotos, totalCollections: Int?
    let instagramUsername, twitterUsername: String?
    let profileImage: ProfileImage?
    let links: UserLinks?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case portfolioURL = "portfolio_url"
        case bio, location
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case instagramUsername = "instagram_username"
        case twitterUsername = "twitter_username"
        case profileImage = "profile_image"
        case links
    }
}


// MARK: - UserLinks
struct UserLinks: Decodable {
    let linksSelf, html, photos, likes: String?
    let portfolio: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio
    }
}


// MARK: - ProfileImage
struct ProfileImage: Decodable {
    let small, medium, large: String?
}

typealias TopicsImagesResults = [TopicsImagesResult]




