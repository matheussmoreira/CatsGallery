//
//  DownloadService.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

protocol DownloadServiceProtocol {
    func getImage(link: String?, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class DownloadService: DownloadServiceProtocol {
    private let serviceLayer = GenericAPIService()
    private var tasks: [URLSessionDataTask] = []
    
    func getImage(link: String?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let link = link, let url = URL(string: link) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        guard !tasks.contains(where: { $0.originalRequest?.url == url }) else {
            return
        }
        
        let newTask = serviceLayer.requestDataTask(for: url, completion: completion)
        tasks.append(newTask)
    }
}
