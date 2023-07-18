//
//  NetworkingEnums.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

enum NetworkError: Error {
    case generic(error: Error)
    case invalidURL
    case noData
    case parsingError(error: Error)
}

enum HTTPMethod: String {
    case GET = "GET"
    // POST, UPDATE, DELETE
}
