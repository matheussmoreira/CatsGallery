//
//  PostData.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

struct PostData: Codable {
    var id: String?
    var title: String?
    var description: AnyCodable? // Possivelmente String
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
    var vote: AnyCodable?
    var favorite: Bool?
    var nsfw: Bool?
    var section: String?
    var comment_count: Int?
    var favorite_count: Int?
    var topic: AnyCodable? // Possivelmente String
    var topic_id: AnyCodable? // Possivelmente Int
    var images_count: Int?
    var in_gallery: Bool?
    var is_ad: Bool?
    var tags: [TagData]?
    var ad_type: Int?
    var ad_url: String?
    var in_most_viral: Bool?
    var include_album_ads: Bool?
    var images: [ImageData]?
    var ad_config: AdConfig?
    
    init(){}
    
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
        self.cover = try container.decodeIfPresent(String.self, forKey: .cover)
        self.cover_width = try container.decodeIfPresent(Int.self, forKey: .cover_width)
        self.cover_height = try container.decodeIfPresent(Int.self, forKey: .cover_height)
        self.account_url = try container.decodeIfPresent(String.self, forKey: .account_url)
        self.account_id = try container.decodeIfPresent(Int.self, forKey: .account_id)
        self.privacy = try container.decodeIfPresent(String.self, forKey: .privacy)
        self.layout = try container.decodeIfPresent(String.self, forKey: .layout)
        self.views = try container.decodeIfPresent(Int.self, forKey: .views)
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
        self.ups = try container.decodeIfPresent(Int.self, forKey: .ups)
        self.downs = try container.decodeIfPresent(Int.self, forKey: .downs)
        self.points = try container.decodeIfPresent(Int.self, forKey: .points)
        self.score = try container.decodeIfPresent(Int.self, forKey: .score)
        self.is_album = try container.decodeIfPresent(Bool.self, forKey: .is_album)
        self.vote = try container.decodeIfPresent(AnyCodable.self, forKey: .vote)
        self.favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite)
        self.nsfw = try container.decodeIfPresent(Bool.self, forKey: .nsfw)
        self.section = try container.decodeIfPresent(String.self, forKey: .section)
        self.comment_count = try container.decodeIfPresent(Int.self, forKey: .comment_count)
        self.favorite_count = try container.decodeIfPresent(Int.self, forKey: .favorite_count)
        self.topic = try container.decodeIfPresent(AnyCodable.self, forKey: .topic)
        self.topic_id = try container.decodeIfPresent(AnyCodable.self, forKey: .topic_id)
        self.images_count = try container.decodeIfPresent(Int.self, forKey: .images_count)
        self.in_gallery = try container.decodeIfPresent(Bool.self, forKey: .in_gallery)
        self.is_ad = try container.decodeIfPresent(Bool.self, forKey: .is_ad)
        self.tags = try container.decodeIfPresent([TagData].self, forKey: .tags)
        self.ad_type = try container.decodeIfPresent(Int.self, forKey: .ad_type)
        self.ad_url = try container.decodeIfPresent(String.self, forKey: .ad_url)
        self.in_most_viral = try container.decodeIfPresent(Bool.self, forKey: .in_most_viral)
        self.include_album_ads = try container.decodeIfPresent(Bool.self, forKey: .include_album_ads)
        self.images = try container.decodeIfPresent([ImageData].self, forKey: .images)
        self.ad_config = try container.decode(AdConfig.self, forKey: .ad_config)
    }
}

// MARK: CodingKeys

extension PostData {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case datetime
        case cover
        case cover_width
        case cover_height
        case account_url
        case account_id
        case privacy
        case layout
        case views
        case link
        case ups
        case downs
        case points
        case score
        case is_album
        case vote
        case favorite
        case nsfw
        case section
        case comment_count
        case favorite_count
        case topic
        case topic_id
        case images_count
        case in_gallery
        case is_ad
        case tags
        case ad_type
        case ad_url
        case in_most_viral
        case include_album_ads
        case images
        case ad_config
    }
}
