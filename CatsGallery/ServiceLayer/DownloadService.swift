//
//  DownloadService.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation
import Combine

protocol DownloadServiceProtocol {
    func getImage(link: String?, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class DownloadService: DownloadServiceProtocol {
    private let serviceLayer = GenericAPIService()
    
    func getImage(link: String?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let link = link, let url = URL(string: link) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let _ = serviceLayer.requestDataTask(for: url, completion: completion)
    }
}
