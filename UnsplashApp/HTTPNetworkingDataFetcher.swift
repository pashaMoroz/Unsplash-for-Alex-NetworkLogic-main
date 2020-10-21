//
//  HTTPNetworkingDataFetcher.swift
//  UnsplashApp
//
//  Created by Алексей Пархоменко on 16.10.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation
import UIKit

enum NetResult<T> {
    case success(T)
    case failure
}

class HTTPNetworkingDataFetcher {
    
    var isWaitingForConnectivityHandler: ((URLSession, URLSessionTask) -> Void)?
    
    private let networking: HTTPNetworking<Unsplash>
    
    init(networking: HTTPNetworking<Unsplash> = HTTPNetworking<Unsplash>()) {
        self.networking = networking
        self.isWaitingForConnectivityHandler = self.networking.isWaitingForConnectivityHandler
    }
    
    func fetchImages(searchTerm: String, completion: @escaping (NetResult<SearchResults>) -> ()) {
        networking.request(.fetchPhotos(searchTerm: searchTerm)) { (result) in
            switch result {
            case .success(let data):
                self.decodeJSON(type: SearchResults.self, from: data) { (result) in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let jsonError):
                        print(jsonError)
                        print(jsonError.localizedDescription)
                        completion(.failure)
                    }
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                completion(.failure)
            }
        }
    }

    func fetchTopicsIDs(from topicTitle: [TopicTitles],  comletion: @escaping () -> Void) {
        networking.request(.fetchTopics) { (result) in

            switch result {

            case .success(let data):

                //Получаем массив топиков topicsDecode
                guard let topicsDecode = self.decodeJSON(type: ListTopicsResults.self, from: data) else { return }

                topicsDecode.forEach({ (topicDecode) in

                    //избавляемся от опционалов в нужных нам значениях
                    guard let titleOfTopicDecode = topicDecode.title else { return }
                    guard let idOfTopicDecode = topicDecode.id else { return }

                    //Делаем проверку на соответсвие нужного нам title из topicDecode (что пришел), с тем, что нас нужен
                    for topic in topicTitle {

                        if topic.title == titleOfTopicDecode {

                            // Записываем в юзер дефолтс id топиков, что нам нужны по title

                            switch titleOfTopicDecode {

                            case TopicTitles.Athletics.title:
                                UserSettings.Athletics = idOfTopicDecode

                            case TopicTitles.History.title:
                                UserSettings.History = idOfTopicDecode

                            case TopicTitles.Technology.title:
                                UserSettings.Technology = idOfTopicDecode
                            default:
                                break
                            }
                            comletion()
                        }
                    }
                })


            case .failure(let error):
                print ("Error received requesting data: \(error.localizedDescription)")
            }
        }
    }

    func fetchTopicsImages(idTopic: String, completion: @escaping (TopicsImagesResults?) -> Void) {
        networking.request(.fetchTopicsImages(id: idTopic)) { (result) in
            switch result {

            case .success(let data):
                let decode = self.decodeJSON(type: TopicsImagesResults.self, from: data)
                completion(decode)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    //    func fetchMyProfile(comletion: @escaping(MyProfileResult?) -> Void) {
    //        networking.request(.fetchMyProfile) { (result) in
    //            switch result {
    //
    //            case .success(let data):
    //                let decode = self.decodeJSON(type: MyProfileResult.self, from: data)
    //                comletion(decode)
    //            case .failure(let error):
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }

    func fetchMyProfile(comletion: @escaping(MyProfileResult?) -> Void) {
        networking.request(.fetchMyProfile) { (result) in

            switch result {
            case .success(let data):
                self.decodeJSON(type: MyProfileResult.self, from: data) { (result) in
                    switch result {
                    case .success(let model):
                        comletion(model)
                    case .failure(let jsonError):
                        print(jsonError)
                        print(jsonError.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()

        do {
            let objects = try decoder.decode(type.self, from: data)
            completion(.success(objects))
        } catch let jsonError {
            completion(.failure(jsonError))
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(json)
        } catch let error {

        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }

        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}

