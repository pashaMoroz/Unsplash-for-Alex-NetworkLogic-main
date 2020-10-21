////
////  NetworkService.swift
////  UnsplashApp
////
////  Created by Pavel Moroz on 25.09.2020.
////  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
////
//
//import Foundation
//
//class NetworkService {
//
//    func request(searchType: ResourceType, completion: @escaping (Data?, Error?) -> Void)  {
//
//        let parameters = self.prepareParaments(searchType: searchType)
//        let url = self.url(searchType: searchType.typeName, params: parameters)
//
//        var request = URLRequest(url: url)
//        request.allHTTPHeaderFields = prepareHeader()
//        request.httpMethod = "get"
//        let task = createDataTask(from: request, completion: completion)
//        task.resume()
//    }
//
//    private func prepareHeader() -> [String: String]? {
//        var headers = [String: String]()
//        headers["Authorization"] = "Client-ID Qy2zCD4_4BeQsxP1zYvZwp_ByovjR3rQXjjFMbAelkI"
//        return headers
//    }
//
//    private func prepareParaments(searchType: ResourceType) -> [String: String] {
//
//        var parameters = [String: String]()
//
//        switch searchType {
//        case .photos (let searchTerm):
//            parameters["query"] = searchTerm
//            parameters["page"] = String(1)
//            parameters["per_page"] = String(30)
//           // parameters["order_by"] = String(UserDefaults.standard.getOrderRequest())
//
//        case .random:
//            parameters["count"] = String(30)
//
//        case .getTopics:
//            parameters["order_by"] = "latest"
//
//        case .getTopicsImages (let id):
//
//            parameters["id_or_slug"] = id
////            parameters["client_id"] = "Qy2zCD4_4BeQsxP1zYvZwp_ByovjR3rQXjjFMbAelkI"
//
//            //UserDefaults.standard.getUserToken()
//
//            //"864f40e4cbc3adc205e2ba2c97d79ae03f72d8def4b797c5a8a1932171c4a685"
//
//        }
//
//        return parameters
//    }
//
//    private func url(searchType: String,  params: [String: String]) -> URL {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "api.unsplash.com"
//        components.path = searchType
//        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
//        return components.url!
//    }
//
//    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
//        return URLSession.shared.dataTask(with: request) { (data, response, error) in
//            DispatchQueue.main.async {
//                completion(data, error)
//            }
//        }
//    }
//}
