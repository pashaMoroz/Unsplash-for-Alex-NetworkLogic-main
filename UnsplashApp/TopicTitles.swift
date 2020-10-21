//
//  TopicTitles.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 30.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

enum TopicTitles {

    case History
    case Athletics
    case Technology

    var title : String {

        switch self {
        
        case .History:
            return "History"
        case .Athletics:
            return "Athletics"
        case .Technology:
            return "Technology"
        }
    }
}
