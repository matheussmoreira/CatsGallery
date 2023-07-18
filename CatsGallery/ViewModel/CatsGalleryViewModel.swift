//
//  CatsGalleryViewModel.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation
import Combine
// <V: Codable, A: Codable, IV: Codable, IT: Codable> 
final class CatsGalleryViewModel {
    let catsService: CatsGalleryServiceProtocol
    var catsData: [CatsData]?
    
    init(catsService: CatsGalleryServiceProtocol = CatsGalleryService()) {
        self.catsService = catsService
    }
    
    func queryCats() -> Future<[CatsData], NetworkError>  {
        return Future { promise in
            self.catsService.getCats { result in
                switch result {
                case .success(let data):
                    self.catsData = data
                    promise(.success(data))
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}
