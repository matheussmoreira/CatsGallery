//
//  CatsGalleryViewModel.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation
import Combine

final class CatsGalleryViewModel {
    let catsService: CatsGalleryServiceProtocol
    var catsData: [PostData]?
    
    init(catsService: CatsGalleryServiceProtocol = CatsGalleryService()) {
        self.catsService = catsService
    }
    
    func queryCats() -> Future<[PostData], NetworkError>  {
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
