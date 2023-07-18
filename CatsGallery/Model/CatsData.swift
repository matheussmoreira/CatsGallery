//
//  CatsData.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation
//<V: Codable, A: Codable, IV: Codable, IT: Codable>
struct CatsData: Codable {
    var id: String?
    var title: String?
    var description: String?
    var datetime: Int?
    var cover: String?
    var cover_width: Int?
    var cover_height: Int?
    var account_url: String?
    var account_id: Int?
    var privacy: String?
    var layout: String?
    var views: Int?
    var link: String?
    var ups: Int?
    var downs: Int?
    var points: Int?
    var score: Int?
    var is_album: Bool?
//    var vote: V?
    var favorite: Bool?
    var nsfw: Bool?
    var section: String?
    var comment_count: Int?
    var favorite_count: Int?
    var topic: String?
    var topic_id: Int?
    var images_count: Int?
    var in_gallery: Bool?
    var is_ad: Bool?
    var tags: [Tag]?
    var ad_type: Int?
    var ad_url: String?
    var in_most_viral: Bool?
    var include_album_ads: Bool?
    var images: [CatImageData]?
    var ad_config: AdConfig
}
