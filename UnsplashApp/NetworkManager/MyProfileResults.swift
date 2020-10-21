import Foundation

// MARK: - MyProfile
struct MyProfileResult: Decodable {
    let id: String?
    let username, firstName, lastName, twitterUsername: String?
    let totalLikes, totalPhotos, totalCollections: String?
    let followedByUser: String?
    let instagramUsername, email: String?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case followedByUser = "followed_by_user"
        case instagramUsername = "instagram_username"
        case email, links
    }
}

// MARK: - Links
struct Links: Decodable {
    let linksSelf, html, photos, likes: String?
    let portfolio: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio
    }
}
