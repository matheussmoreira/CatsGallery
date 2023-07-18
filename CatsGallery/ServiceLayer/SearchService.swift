//
//  SearchService.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation

protocol SearchServiceProtocol {
    func getPosts(completion: @escaping (Result<[PostData], NetworkError>) -> Void)
}

class SearchService: SearchServiceProtocol {
    private let url: URL?
    private let serviceLayer = GenericAPIService()
    
    init(endpoint: String = "https://api.imgur.com/3/gallery/search/?q=cats") {
        self.url = URL(string: endpoint)
    }
    
    func getPosts(completion: @escaping (Result<[PostData], NetworkError>) -> Void) {
        serviceLayer.requestDataTask(for: url, httpMethod: .GET, completion: completion)
    }
}
