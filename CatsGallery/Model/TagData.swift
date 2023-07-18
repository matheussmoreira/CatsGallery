//
//  TagData.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

struct TagData: Codable {
    var name: String?
    var display_name: String?
    var followers: Int?
    var total_items: Int?
    var following: Bool?
    var is_whitelisted: Bool?
    var background_hash: String?
    var thumbnail_hash: AnyCodable? // Possivelmente String
    var accent: String?
    var background_is_animated: Bool?
    var thumbnail_is_animated: Bool?
    var is_promoted: Bool?
    var description: String?
    var logo_hash: AnyCodable? // Possivelmente String
    var logo_destination_url: AnyCodable? // Possivelmente String
    var description_annotations: AnyCodable?
    
    /*  Custom decoder usado para lidar com os AnyCodables.
        Como não é possivel decodificar apenas eles de modo customizado,
            as outras propriedades também tiveram que ser incluídas.
        O code completion do Xcode facilitou este trabalho!
     */
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.display_name = try container.decodeIfPresent(String.self, forKey: .display_name)
        self.followers = try container.decodeIfPresent(Int.self, forKey: .followers)
        self.total_items = try container.decodeIfPresent(Int.self, forKey: .total_items)
        self.following = try container.decodeIfPresent(Bool.self, forKey: .following)
        self.is_whitelisted = try container.decodeIfPresent(Bool.self, forKey: .is_whitelisted)
        self.background_hash = try container.decodeIfPresent(String.self, forKey: .background_hash)
        self.thumbnail_hash = try container.decodeIfPresent(AnyCodable.self, forKey: .thumbnail_hash)
        self.accent = try container.decodeIfPresent(String.self, forKey: .accent)
        self.background_is_animated = try container.decodeIfPresent(Bool.self, forKey: .background_is_animated)
        self.thumbnail_is_animated = try container.decodeIfPresent(Bool.self, forKey: .thumbnail_is_animated)
        self.is_promoted = try container.decodeIfPresent(Bool.self, forKey: .is_promoted)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.logo_hash = try container.decodeIfPresent(AnyCodable.self, forKey: .logo_hash)
        self.logo_destination_url = try container.decodeIfPresent(AnyCodable.self, forKey: .logo_destination_url)
        self.description_annotations = try container.decodeIfPresent(AnyCodable.self, forKey: .description_annotations)
    }
}

// MARK: - CodingKeys

extension TagData {
    enum CodingKeys: String, CodingKey {
        case name
        case display_name
        case followers
        case total_items
        case following
        case is_whitelisted
        case background_hash
        case thumbnail_hash
        case accent
        case background_is_animated
        case thumbnail_is_animated
        case is_promoted
        case description
        case logo_hash
        case logo_destination_url
        case description_annotations
    }
}
