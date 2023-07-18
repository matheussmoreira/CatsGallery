//
//  AdConfig.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

struct AdConfig: Codable {
    let safeFlags: [String]?
    let highRiskFlags: [String]?
    let unsafeFlags: [String]?
    let wallUnsafeFlags: [String]?
    let showsAds: Bool?
    let showAdLevel: Int?
    let safe_flags: [String]?
    let high_risk_flags: [String]?
    let unsafe_flags: [String]?
    let wall_unsafe_flags: [String]?
    let show_ads: Bool?
    let show_ad_level: Int?
    let nsfw_score: Int?
}
