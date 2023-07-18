//
//  CatImageData.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation
// <V: Codable, T: Codable>
struct CatImageData: Codable {
    var id: String?
    var title: String?
    var description: String?
    var datetime: Int?
    var type: String?
    var animated: Bool?
    var width: Int?
    var height: Int?
    var size: Int?
    var views: Int?
    var bandwidth: Int?
//    var vote: V?
    var favorite: Bool?
    var nsfw: Bool?
    var section: String?
    var account_url: String?
    var account_id: Int?
    var is_ad: Bool?
    var in_most_viral: Bool?
    var has_sound: Bool?
//    var tags: [T]?
    var ad_type: Int?
    var ad_url: String?
    var edited: String?
    var in_gallery: Bool?
    var link: String?
    var comment_count: Int?
    var favorite_count: Int?
    var ups: Int?
    var downs: Int?
    var points: Int?
    var score: Int?
}
