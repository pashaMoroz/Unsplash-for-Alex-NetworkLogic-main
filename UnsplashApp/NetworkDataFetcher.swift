////
////  NetworkDataFetcher.swift
////  UnsplashApp
////
////  Created by Pavel Moroz on 25.09.2020.
////  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
////
//
//import Foundation
//
//
//class NetworkDataFetcher {
//
//    var networkService = NetworkService()
//
//    func fetchImages(searchType: ResourceType, completion: @escaping (SearchResults?) -> ()) {
//        networkService.request(searchType: searchType) { (data, error) in
//            if let error = error {
//                print("Error received requesting data: \(error.localizedDescription)")
//                completion(nil)
//            }
//
//            let decode = self.decodeJSON(type: SearchResults.self, from: data)
//            completion(decode)
//        }
//    }
//
//    func getImages(idTopic: String, completion: @escaping (TopicsImagesResults?) -> ()) {
//
//        networkService.request(searchType: .getTopicsImages(id: idTopic)) { (data, error) in
//            if let error = error {
//                print("Error received requesting data: \(error.localizedDescription)")
//                completion(nil)
//            }
//
//            let decode = self.decodeJSON(type: TopicsImagesResults.self, from: data)
//            completion(decode)
//        }
//    }
//
//    func getsCurrensTopicsIDs(from topicTitle: [TopicTitles]) {
//
//        //отправляем запрос на получение данных data по определенным настройкам (в зависимости от searchType)
//        networkService.request(searchType: .getTopics) { (data, error) in
//
//            //проверяем на ошибки
//            if let error = error {
//                print ("Error received requesting data: \(error.localizedDescription)")
//                //completion(nil)
//            }
//
//            //Получаем массив топиков topicsDecode
//            guard let topicsDecode = self.decodeJSON(type: ListTopicsResults.self, from: data) else { return }
//
//            //Проходимся по каждому топику из массива topicsDecode
//            topicsDecode.forEach({ (topicDecode) in
//
//                //избавляемся от опционалов в нужных нам значениях
//                guard let titleOfTopicDecode = topicDecode.title else { return }
//                guard let idOfTopicDecode = topicDecode.id else { return }
//
//                //Делаем проверку на соответсвие нужного нам title из topicDecode (что пришел), с тем, что нас нужен
//                for topic in topicTitle {
//
//                    if topic.title == titleOfTopicDecode {
//
//                        // Записываем в юзер дефолтс id топиков, что нам нужны по title
//
//                        switch titleOfTopicDecode {
//
//                        case TopicTitles.Athletics.title:
//                            UserSettings.Athletics = idOfTopicDecode
//
//                        case TopicTitles.History.title:
//                            UserSettings.History = idOfTopicDecode
//
//                        case TopicTitles.Technology.title:
//                            UserSettings.Technology = idOfTopicDecode
//                        default:
//                            break
//                        }
//                    }
//                }
//            })
//        }
//    }
//
//    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
//        let decoder = JSONDecoder()
//        guard let data = from else { return nil }
//
//        do {
//            let objects = try decoder.decode(type.self, from: data)
//            return objects
//        } catch let jsonError {
//            print("Failed to decode JSON", jsonError)
//            return nil
//        }
//    }
//}
