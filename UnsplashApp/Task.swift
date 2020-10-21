//
//  Task.swift
//  TrackerFramework
//
//  Created by Алексей Пархоменко on 28.09.2020.
//

import Foundation

public enum Task {
  case requestWithParameters([String: Any])
  case requestWithEncodable(Encodable)
}
