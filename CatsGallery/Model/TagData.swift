//
//  TagData.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

struct TagData: Codable {
    let name, displayName: String?
    let followers, totalItems: Int?
    let following, isWhitelisted: Bool?
    let backgroundHash: String?
    let thumbnailHash, accent: String?
    let backgroundIsAnimated, thumbnailIsAnimated, isPromoted: Bool?
    let description: String?
    let logoHash, logoDestinationURL: AnyCodable?
//    let descriptionAnnotations: AnyCodable?

    enum CodingKeys: String, CodingKey {
        case name
        case displayName = "display_name"
        case followers
        case totalItems = "total_items"
        case following
        case isWhitelisted = "is_whitelisted"
        case backgroundHash = "background_hash"
        case thumbnailHash = "thumbnail_hash"
        case accent
        case backgroundIsAnimated = "background_is_animated"
        case thumbnailIsAnimated = "thumbnail_is_animated"
        case isPromoted = "is_promoted"
        case description
        case logoHash = "logo_hash"
        case logoDestinationURL = "logo_destination_url"
//        case descriptionAnnotations = "description_annotations"
    }
}
