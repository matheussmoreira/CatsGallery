//
//  CatsGalleryViewModel.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import Foundation
import Combine

final class CatsGalleryViewModel {
    
    // MARK: Instance Properties
    
//    var postsData = [PostData]()
    var links = [String]()
    var imagesData = [Data]()
    let searchService: SearchServiceProtocol
    let downloadService: DownloadServiceProtocol
    
    // MARK: Initialization
    
    init(searchService: SearchServiceProtocol = SearchService(),
         downloadService: DownloadServiceProtocol = DownloadService()) {
        self.searchService = searchService
        self.downloadService = downloadService
    }
    
    // MARK: Networking Methods
    
    func searchCatsPosts(execute handler: () -> Void) -> Future<[PostData], NetworkError> {
        handler()
        return Future { promise in
            print("Searching cats...")
            self.searchService.getPosts { result in
                switch result {
                case .success(let response):
                    guard let data = response.data else { return  }
                    for data in data {
                        guard let images = data.images else { continue }
                        for image in images {
                            guard let link = image.link else { continue }
                            self.links.append(link)
                        }
                    }
                    promise(.success(data))
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    func downloadCatsImages() -> [Future<Data, NetworkError>] {
        return links.map { link in
            downloadImage(link: link)
        }
    }
    
    private func downloadImage(link: String?) -> Future<Data, NetworkError> {
        return Future { promise in
            DispatchQueue.global(qos: .utility).async {
                print("Requesting image for \(String(describing: link))")
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
    
    // MARK: Other Methods
    
    func erase() {
        links = []
        imagesData = []
    }
}
