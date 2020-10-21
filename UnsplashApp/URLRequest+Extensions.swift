//
//  URLRequest+Extensions.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

extension URLRequest {
    init(resource: ResourceType) {
        var url = resource.baseURL.appendingPathComponent(resource.endpoint.path)
        
        if case let .requestWithParameters(parameters) = resource.task {
            url = url.appendingQueryParameters(parameters, encoding: URLEncoding())
        }
        
        print(resource)
        print(url)
        self.init(url: url)
        
        httpMethod = resource.endpoint.method.rawValue
        print(resource.endpoint.method.rawValue)
        
        for (key, value) in resource.headers {
            print(key, value)
            addValue(value, forHTTPHeaderField: key)
        }
        
        if resource.endpoint.method == .post || resource.endpoint.method == .put {
            if case let .requestWithEncodable(encodable) = resource.task {
                let anyEncodable = AnyEncodable(encodable)
                httpBody = encode(object: anyEncodable)
            }
            if case let .requestWithParameters(parameters) = resource.task {
                print(parameters)
                httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                print("httpBody", httpBody)
            }
        }
    }
    
    func encode<E>(object: E) -> Data? where E : Encodable {
        return try? JSONEncoder().encode(object)
    }
}
