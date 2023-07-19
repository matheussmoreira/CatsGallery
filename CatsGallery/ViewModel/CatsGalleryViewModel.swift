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
    
    var links = [String]()
    var imagesData = [Data]()
    var totalDisplay = 48
    let searchService: SearchServiceProtocol
    let downloadService: DownloadServiceProtocol
    let queue = DispatchQueue(label: "Download task", qos: .utility, attributes: .concurrent)
    
    var hasLinks: Bool { !links.isEmpty }
    var initialRange: ClosedRange<Int> { 0...48 }
    
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
    
    func downloadCatsImages(onRange range: ClosedRange<Int>) -> [Future<Data, NetworkError>] {
        let firstIndex = getSafeIndex(from: range.first)
        let lastIndex = getSafeIndex(from: range.last)
        let safeRange = firstIndex...lastIndex
        
        return links[safeRange].map { link in
            downloadImage(from: link)
        }
    }
    
    private func getSafeIndex(from index: Int?) -> Int {
        var newIndex = index ?? 0
        if let index = index, index >= links.count {
            newIndex = links.count-1
        }
        return newIndex
    }
    
    private func downloadImage(from link: String?) -> Future<Data, NetworkError> {
        return Future { promise in
            self.queue.async {
                print("Requesting image for \(String(describing: link)))")
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
