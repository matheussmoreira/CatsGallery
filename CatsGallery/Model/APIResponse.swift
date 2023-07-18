//
//  APIResponse.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

struct APIResponse: Codable {
    let data: [PostData]?
    let success: Bool?
    let status: Int?
}
