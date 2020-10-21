//
//  MainVCSection.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 21.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

struct MainVCSection: Hashable {
    let uuid = UUID()
    let type: String
    let id: Int
    let items: [MainVCItems]
}
