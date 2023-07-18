//
//  CatsGalleryViewModel.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation
import Combine

final class CatsGalleryViewModel {
    let searchService: SearchServiceProtocol
    let downloadService: DownloadServiceProtocol
    var postsData = [PostData]()
    var imagesData = [Data]()
    
    init(searchService: SearchServiceProtocol = SearchService(),
         downloadService: DownloadServiceProtocol = DownloadService()) {
        self.searchService = searchService
        self.downloadService = downloadService
    }
    
    func queryPosts(execute handler: () -> Void) -> Future<[PostData], NetworkError> {
        handler()
        return Future { promise in
            self.searchService.getPosts { result in
                switch result {
                case .success(let response):
                    if let data = response.data {
                        self.postsData = data
                        promise(.success(data))
                    }
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    func downloadImages() -> Future<Data, NetworkError> {
        for data in postsData {
            guard let images = data.images else { continue }
            for image in images {
                return downloadImage(link: image.link)
            }
        }
        
        return Future { promise in
            promise(.failure(.noData))
        }
    }
    
    private func downloadImage(link: String?) -> Future<Data, NetworkError> {
        return Future { promise in
            self.downloadService.getImage(link: link) { result in
                switch result {
                case .success(let data):
                    self.imagesData.append(data)
                    promise(.success(data))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}
