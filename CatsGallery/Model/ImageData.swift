//
//  ImageData.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

struct ImageData: Codable {
    var id: String?
    var title: String?
    var description: AnyCodable? // Possivelmente String
    var datetime: Int?
    var type: String?
    var animated: Bool?
    var width: Int?
    var height: Int?
    var size: Int?
    var views: Int?
    var bandwidth: Int?
    var vote: AnyCodable?
    var favorite: Bool?
    var nsfw: AnyCodable? // Possivelmente Bool
    var section: AnyCodable? // Possivelmente String
    var account_url: AnyCodable? // Possivelmente String
    var account_id: AnyCodable? // Possivelmente Int
    var is_ad: Bool?
    var in_most_viral: Bool?
    var has_sound: Bool?
    var tags: [AnyCodable]?
    var ad_type: Int?
    var ad_url: String?
    var edited: String?
    var in_gallery: Bool?
    var link: String?
    var comment_count: AnyCodable? // Possivelmente Int
    var favorite_count: AnyCodable? // Possivelmente Int
    var ups: AnyCodable? // Possivelmente Int
    var downs: AnyCodable? // Possivelmente Int
    var points: AnyCodable? // Possivelmente Int
    var score: AnyCodable? // Possivelmente Int
    
    /*  Custom decoder usado para lidar com os AnyCodables.
        Como não é possivel decodificar apenas eles de modo customizado,
            as outras propriedades também tiveram que ser incluídas.
        O code completion do Xcode facilitou este trabalho!
     */
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(AnyCodable.self, forKey: .description)
        self.datetime = try container.decodeIfPresent(Int.self, forKey: .datetime)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.animated = try container.decodeIfPresent(Bool.self, forKey: .animated)
        self.width = try container.decodeIfPresent(Int.self, forKey: .width)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.views = try container.decodeIfPresent(Int.self, forKey: .views)
        self.bandwidth = try container.decodeIfPresent(Int.self, forKey: .bandwidth)
        self.vote = try container.decodeIfPresent(AnyCodable.self, forKey: .vote)
        self.favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite)
        self.nsfw = try container.decodeIfPresent(AnyCodable.self, forKey: .nsfw)
        self.section = try container.decodeIfPresent(AnyCodable.self, forKey: .section)
        self.account_url = try container.decodeIfPresent(AnyCodable.self, forKey: .account_url)
        self.account_id = try container.decodeIfPresent(AnyCodable.self, forKey: .account_id)
        self.is_ad = try container.decodeIfPresent(Bool.self, forKey: .is_ad)
        self.in_most_viral = try container.decodeIfPresent(Bool.self, forKey: .in_most_viral)
        self.has_sound = try container.decodeIfPresent(Bool.self, forKey: .has_sound)
        self.tags = try container.decodeIfPresent([AnyCodable].self, forKey: .tags)
        self.ad_type = try container.decodeIfPresent(Int.self, forKey: .ad_type)
        self.ad_url = try container.decodeIfPresent(String.self, forKey: .ad_url)
        self.edited = try container.decodeIfPresent(String.self, forKey: .edited)
        self.in_gallery = try container.decodeIfPresent(Bool.self, forKey: .in_gallery)
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
        self.comment_count = try container.decodeIfPresent(AnyCodable.self, forKey: .comment_count)
        self.favorite_count = try container.decodeIfPresent(AnyCodable.self, forKey: .favorite_count)
        self.ups = try container.decodeIfPresent(AnyCodable.self, forKey: .ups)
        self.downs = try container.decodeIfPresent(AnyCodable.self, forKey: .downs)
        self.points = try container.decodeIfPresent(AnyCodable.self, forKey: .points)
        self.score = try container.decodeIfPresent(AnyCodable.self, forKey: .score)
    }
}

// MARK: - CodingKeys

extension ImageData {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case datetime
        case type
        case animated
        case width
        case height
        case size
        case views
        case bandwidth
        case vote
        case favorite
        case nsfw
        case section
        case account_url
        case account_id
        case is_ad
        case in_most_viral
        case has_sound
        case tags
        case ad_type
        case ad_url
        case edited
        case in_gallery
        case link
        case comment_count
        case favorite_count
        case ups
        case downs
        case points
        case score
    }
}
