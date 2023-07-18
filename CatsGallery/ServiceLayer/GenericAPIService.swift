//
//  GenericAPIService.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation

typealias APICompletion<T: Codable> = (Result<T, NetworkError>) -> Void

class GenericAPIService {
    func requestDataTask<T: Codable>(from url: URL?, httpMethod: HTTPMethod, completion: @escaping APICompletion<T>) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let clientId = "1ceddedc03a5d71"
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        
        request.addValue("Client-ID {{\(clientId)}}", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.generic(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            #warning("Mover o parsing para outro lugar")
            do {
                let parsedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(parsedData))
            } catch let error {
                completion(.failure(.parsingError(error: error)))
            }
        }
        task.resume()
    }
}
