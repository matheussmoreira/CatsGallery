//
//  Tag.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation
// <A: Codable>
struct Tag: Codable {
    var name: String?
    var display_name: String?
    var followers: Int?
    var total_items: Int?
    var following: Bool?
    var is_whitelisted: Bool?
    var background_hash: String?
    var thumbnail_hash: String?
    var accent: String?
    var background_is_animated: Bool?
    var thumbnail_is_animated: Bool?
    var is_promoted: Bool?
    var description: String?
    var logo_hash: String?
    var logo_destination_url: String?
//    var description_annotations: A?
}
