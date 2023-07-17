//
//  CatsService.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation

typealias APICompletion<T: Codable> = (Result<T, NetworkError>) -> Void

enum NetworkError: Error {
    case generic(error: Error)
    case invalidURL
    case noData
    case parsingError(error: Error)
}

protocol CatsServiceProtocol {
    func getCats(completion: @escaping (Result<[Data], NetworkError>) -> Void)
}

class CatsService: CatsServiceProtocol {
    private let endpoint: String
    private let url: URL?
    
    init(endpoint: String = "https://api.imgur.com/3/gallery/search/?q=cats") {
        self.endpoint = endpoint
        self.url = URL(string: endpoint)
    }
    
    func getCats<T: Codable>(completion: @escaping APICompletion<T>) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let clientId = "1ceddedc03a5d71"
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        
        request.addValue("Client-ID {{\(clientId)}}", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response)
            if let error = error {
                completion(.failure(.generic(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch let error {
                completion(.failure(.parsingError(error: error)))
            }
        }
        task.resume()
    }
}
