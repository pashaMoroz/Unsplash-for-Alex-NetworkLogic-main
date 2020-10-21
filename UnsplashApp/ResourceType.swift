//
//  ResourceType.swift
//  TrackerFramework
//
//  Created by Алексей Пархоменко on 28.09.2020.
//

import Foundation

public protocol ResourceType {
  var baseURL: URL { get }
  var endpoint: Endpoint { get }
  var task: Task { get }
  var headers: [String: String] { get }
}

enum Unsplash {
    case fetchPhotos(searchTerm: String)
    case fetchRandomPhoto
    case fetchTopics
    case fetchTopicsImages(id: String)
    case fetchMyProfile
}

extension Unsplash: ResourceType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.unsplash.com") else {
          // should handle this case better
          fatalError("URL doesn't work")
        }
        return url
    }
    
    var endpoint: Endpoint {
        switch self {
        case .fetchPhotos:
            return .get(path: "/search/photos")
        case .fetchRandomPhoto:
            return .get(path: "/photos/random")
        case .fetchTopics:
            return .get(path: "/topics")
        case .fetchTopicsImages(let id):
            return .get(path: "/topics/\(id)/photos")
        case .fetchMyProfile:
            return .get(path: "/me")
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPhotos(let searchTerm):
            var params: [String: String] = [:]
            params["query"] = searchTerm
            params["page"] = String(1)
            params["per_page"] = String(30)
            
            return .requestWithParameters(params)
            
        case .fetchRandomPhoto:
            var params: [String: Any] = [:]
            params["count"] = String(30)
            return .requestWithParameters(params)

        case .fetchTopics:
            var params: [String: Any] = [:]
            params["order_by"] = "latest"
            return .requestWithParameters(params)

        case .fetchTopicsImages(let id):
            var params: [String: Any] = [:]
            params["id_or_slug"] = id
            return .requestWithParameters(params)

        case .fetchMyProfile:
            var params: [String: Any] = [:]
            params["client_id"] = Configuration.UnsplashSettings.clientID
            return .requestWithParameters(params)
        }
    }
    
    var headers: [String : String] {
        return ["Authorization": "Client-ID \(Configuration.UnsplashSettings.clientID)"]
    }
}

//gejOvM5wF4BbI2KflO9H_jjsdNdxOqANLjZmj1Sz8Ic
//https://api.unsplash.com/me?client_id=g864f40e4cbc3adc205e2ba2c97d79ae03f72d8def4b797c5a8a1932171c4a685
