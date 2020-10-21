//
//  PhotoInfoModel.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 22.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

struct PhotoInfoModel: Hashable {
    let image: UIImage
    let name: String
    let like: Bool
    let photoInfo: String
    
    let uuid = UUID()

}
