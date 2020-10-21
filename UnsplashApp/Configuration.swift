//
//  Configuration.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 24.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

struct Configuration {

    struct UnsplashSettings {

        static let shared = Configuration()
        private init() {}

        static let host         = "unsplash.com"
        static let clientID     = Secrets.clientID
        static let clientSecret = Secrets.clientSecret
        static let authorizeURL = "https://unsplash.com/oauth/authorize"
        static let tokenURL     = "https://unsplash.com/oauth/token"
        static let redirectURL = "splashr-x://unsplash"

        struct Secrets {

            static let clientID: String = "Qy2zCD4_4BeQsxP1zYvZwp_ByovjR3rQXjjFMbAelkI"
            static let clientSecret: String = "PBTHaCF1tnLTrUikjtvRLbCu5qv6HaVQCe9mciCybpo"

        }
    }
}
