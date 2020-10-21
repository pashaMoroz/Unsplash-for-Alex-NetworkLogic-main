//
//  Scope.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 24.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

enum Scope: String, CaseIterable {
    case pub = "public"
    case readUser = "read_user"
    case writeUser = "write_user"
    case readPhotos = "read_photos"
    case writePhotos = "write_photos"
    case writeLikes = "write_likes"
    case writeFollowers = "write_followers"
    case readCollections = "read_collections"

    case writeCollections = "write_collections"

}
