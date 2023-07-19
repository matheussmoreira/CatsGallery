//
//  ImageData.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

struct ImageData: Codable {
    let id: String?
    let title: String?
    let description: String?
    let datetime: Int?
    var type: String?
    let animated: Bool?
    let width, height, size, views: Int?
    let bandwidth: Int?
    let vote: AnyCodable?
    let favorite: Bool?
    let nsfw, section, accounturl, accountid: AnyCodable?
    let isAd, inMostViral, hasSound: Bool?
    let tags: [AnyCodable]?
    let adType: Int?
    let adurl, edited: String?
    let inGallery: Bool?
    let link: String?
    let commentCount, favoriteCount, ups, downs: AnyCodable?
    let points, score: AnyCodable?
//    let mp4Size: Int?
//    let mp4: String?
//    let gifv: String?
//    let hls: String?
//    let processing: String?

    enum CodingKeys: String, CodingKey {
        case id, title, description, datetime, type, animated, width, height, size, views, bandwidth, vote, favorite, nsfw, section
        case accounturl = "account_url"
        case accountid = "account_id"
        case isAd = "is_ad"
        case inMostViral = "in_most_viral"
        case hasSound = "has_sound"
        case tags
        case adType = "ad_type"
        case adurl = "ad_url"
        case edited
        case inGallery = "in_gallery"
        case link
        case commentCount = "comment_count"
        case favoriteCount = "favorite_count"
        case ups, downs, points, score
//        case mp4Size = "mp4_size"
//        case mp4, gifv, hls, processing
    }
}
