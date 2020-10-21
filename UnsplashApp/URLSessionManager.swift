//
//  URLSessionManager.swift
//  TrackerFramework
//
//  Created by Алексей Пархоменко on 28.09.2020.
//

import Foundation

public class URLSessionManager {
  weak var taskDelegate: URLSessionTaskDelegate?
  
  var session: URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.waitsForConnectivity = true
    return URLSession(configuration: configuration, delegate: taskDelegate, delegateQueue: nil)
  }
  
  private init() { }
  
  public static let shared = URLSessionManager()
}

