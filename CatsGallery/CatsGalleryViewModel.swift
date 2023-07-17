//
//  CatsGalleryViewModel.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation
import Combine

final class CatsGalleryViewModel {
    let catsService: CatsServiceProtocol
    var catsData: [Data]?
    
    init(catsService: CatsServiceProtocol = CatsService()) {
        self.catsService = catsService
    }
    
    func queryCats() -> Future<[Data], NetworkError>  {
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
