//
//  URLSession+Extensions.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

protocol HTTPNetworkingSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask
}

extension URLSession: HTTPNetworkingSession {
    public func loadData( with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            DispatchQueue.main.async {
                completionHandler(data, urlResponse, error)
            }
        }
        task.resume()
        return task
    }
}
