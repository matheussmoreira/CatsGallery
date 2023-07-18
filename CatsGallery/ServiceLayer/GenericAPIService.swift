//
//  GenericAPIService.swift
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

class GenericAPIService {
    func requestDataTask<T: Codable>(from url: URL?, completion: @escaping APICompletion<T>) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let clientId = "1ceddedc03a5d71"
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        
        request.addValue("Client-ID {{\(clientId)}}", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
