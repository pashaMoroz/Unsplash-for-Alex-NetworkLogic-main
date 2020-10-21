//
//  UnsplashAccessToken.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 24.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

public struct UnsplashAccessToken : Codable {

    var appId: String?
    let accessToken: String?
    let refreshToken: String?
    let tokenType:String?

    enum CodingKeys: String, CodingKey {

        case appId = "appId"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType   = "token_type"
    }

    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)
        let appId = try values.decodeIfPresent(String.self, forKey: .appId)
        let accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        let refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
        let tokenType = "bearer"
        self.init(appId:appId, accessToken: accessToken, refreshToken: refreshToken, tokenType: tokenType)
    }

    public init(appId: String?, accessToken: String?,refreshToken: String?, tokenType: String = "bearer" ) {
        self.appId = appId ?? Configuration.UnsplashSettings.clientID
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.tokenType = tokenType
    }
}

