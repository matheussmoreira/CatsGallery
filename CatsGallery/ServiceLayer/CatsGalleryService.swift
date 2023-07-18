//
//  CatsGalleryService.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation

protocol CatsGalleryServiceProtocol {
    func getCats(completion: @escaping (Result<[Data], NetworkError>) -> Void)
}

class CatsGalleryService: CatsGalleryServiceProtocol {
    private let endpoint: String
    private let url: URL?
    private let serviceLayer = GenericAPIService()
    
    init(endpoint: String = "https://api.imgur.com/3/gallery/search/?q=cats") {
        self.endpoint = endpoint
        self.url = URL(string: endpoint)
    }
    
    func getCats<T: Codable>(completion: @escaping APICompletion<T>) {
        serviceLayer.requestDataTask(from: url, completion: completion)
    }
}
