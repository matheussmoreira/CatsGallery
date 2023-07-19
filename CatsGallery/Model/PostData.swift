//
//  PostData.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

struct PostData: Codable {
    let id, title: String?
    let description: AnyCodable?
    let datetime: Int?
    let cover: String?
    let coverWidth, coverHeight: Int?
    let accounturl: String?
    let accountid: Int?
    var privacy: String?
    var layout: String?
    let views: Int?
    let link: String?
    let ups, downs, points, score: Int?
    let isAlbum: Bool?
    let vote: AnyCodable?
    let favorite, nsfw: Bool?
    var section: String?
    let commentCount, favoriteCount: Int?
    let topic, topicid: AnyCodable?
    let imagesCount: Int?
    let inGallery, isAd: Bool?
    let tags: [TagData]?
    let adType: Int?
    let adurl: String?
    let inMostViral, includeAlbumAds: Bool?
    let images: [ImageData]?
    let adConfig: AdConfig?

    enum CodingKeys: String, CodingKey {
        case id, title, description, datetime, cover
        case coverWidth = "cover_width"
        case coverHeight = "cover_height"
        case accounturl = "account_url"
        case accountid = "account_id"
        case privacy, layout, views, link, ups, downs, points, score
        case isAlbum = "is_album"
        case vote, favorite, nsfw, section
        case commentCount = "comment_count"
        case favoriteCount = "favorite_count"
        case topic
        case topicid = "topic_id"
        case imagesCount = "images_count"
        case inGallery = "in_gallery"
        case isAd = "is_ad"
        case tags
        case adType = "ad_type"
        case adurl = "ad_url"
        case inMostViral = "in_most_viral"
        case includeAlbumAds = "include_album_ads"
        case images
        case adConfig = "ad_config"
    }
}
