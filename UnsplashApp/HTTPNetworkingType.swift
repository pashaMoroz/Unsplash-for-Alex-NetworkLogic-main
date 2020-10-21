//
//  HTTPNetworkingType.swift
//  TrackerFramework
//
//  Created by Алексей Пархоменко on 28.09.2020.
//

import Foundation

protocol HTTPNetworkingType {
  
  associatedtype Resource
    
  func request(
    _ resource: Resource,
    completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask
  
}
