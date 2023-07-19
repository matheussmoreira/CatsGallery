//
//  CatsGalleryViewModelTests.swift
//  CatsGalleryTests
//
//  Created by Matheus Moreira on 17/07/23.
//

import XCTest
import Combine
import UIKit
@testable import CatsGallery

enum ErrorMock: Error {
    case error
}

final class CatsGalleryViewModelTests: XCTestCase {
    
    /// System under test.
    private var sut: CatsGalleryViewModel!
    private var searchServiceMock: SearchServiceMock!
    private var downloadServiceMock: DownloadServiceMock!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        searchServiceMock = SearchServiceMock()
        downloadServiceMock = DownloadServiceMock()
        sut = CatsGalleryViewModel(searchService: searchServiceMock,
                                   downloadService: downloadServiceMock)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        sut = nil
        searchServiceMock = nil
        downloadServiceMock = nil
        cancellables = nil
    }
}

// MARK: - Search Posts

extension CatsGalleryViewModelTests {
    func testSearchPostsWithSuccess() {
        sut.searchCatsPosts { }.sink { completion in
            switch completion {
            case .finished: break
            default:
                XCTFail("Requisição deveria ter sido bem sucedida!")
            }
        } receiveValue: { _ in
            XCTAssertFalse(self.sut.links.isEmpty)
        }.store(in: &cancellables)
        
        let imageDataMock = ImageData(id: "", title: "", description: "", datetime: 0, animated: false, width: 0, height: 0, size: 0, views: 0, bandwidth: 0, vote: nil, favorite: true, nsfw: nil, section: nil, accounturl: nil, accountid: nil, isAd: false, inMostViral: false, hasSound: true, tags: nil, adType: 2, adurl: "", edited: "", inGallery: false, link: "link", commentCount: nil, favoriteCount: nil, ups: nil, downs: nil, points: nil, score: nil)
        
        let postDataMock = PostData(id: "id", title: "title", description: nil, datetime: 1234, cover: "cover", coverWidth: 1, coverHeight: 1, accounturl: "url", accountid: 1, privacy: "privacy", layout: "layout", views: 0, link: "link", ups: 2, downs: 2, points: 0, score: 0, isAlbum: false, vote: nil, favorite: true, nsfw: false, section: "section", commentCount: 6, favoriteCount: 4, topic: nil, topicid: nil, imagesCount: 4, inGallery: false, isAd: false, tags: [], adType: 4, adurl: "url", inMostViral: false, includeAlbumAds: false, images: [imageDataMock], adConfig: nil)
        
        let response = APIResponse(data: [postDataMock], success: true, status: 200)
        
        searchServiceMock.getPostsWithSuccess(response)
    }
    
    func testSearchPostsWithNoDataError() {
        sut.searchCatsPosts { }.sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                switch error {
                case .noData:
                    XCTAssert(true)
                default:
                    XCTFail("NetworkError deveria ser do tipo noData!")
                }
            }
        } receiveValue: { _ in
            XCTFail("Requisição deveria ter falhado!")
        }.store(in: &cancellables)
        
        searchServiceMock.getPostsWithNoData()
    }
    
    func testSearchPostsWithInvalidURLError() {
        sut.searchCatsPosts { }.sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                switch error {
                case .invalidURL:
                    XCTAssert(true)
                default:
                    XCTFail("NetworkError deveria ser do tipo invalidURL!")
                }
            }
        } receiveValue: { _ in
            XCTFail("Requisição deveria ter falhado!")
        }.store(in: &cancellables)
        
        searchServiceMock.getPostsWithInvalidURL()
    }
    
    func testSearchPostsWithParsingError() {
        sut.searchCatsPosts { }.sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                switch error {
                case .parsingError(error: _):
                    XCTAssert(true)
                default:
                    XCTFail("NetworkError deveria ser do tipo parsingError!")
                }
            }
        } receiveValue: { _ in
            XCTFail("Requisição deveria ter falhado!")
        }.store(in: &cancellables)
        
        searchServiceMock.getPostsWithParsingError(ErrorMock.error)
    }
    
    func testSearchPostsWithGenericError() {
        sut.searchCatsPosts { }.sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                switch error {
                case .generic(error: _):
                    XCTAssert(true)
                default:
                    XCTFail("NetworkError deveria ser do tipo generic!")
                }
            }
        } receiveValue: { _ in
            XCTFail("Requisição deveria ter falhado!")
        }.store(in: &cancellables)
        
        searchServiceMock.getPostsWithGenericError(ErrorMock.error)
    }
}

// MARK: - Download Images

extension CatsGalleryViewModelTests {
    func testDownloadImagesWithSuccess() throws {
        sut.links.append(contentsOf: ["link1","link2","link3"])
        
        let downloads = sut.downloadCatsImages(onRange: 0...0)
        downloads.forEach {
            $0.sink { completion in
                switch completion {
                case .finished: break
                default:
                    XCTFail("Requisição deveria ter sido bem sucedida!")
                }
            } receiveValue: { _ in
                XCTAssertFalse(self.sut.imagesData.isEmpty)
            }.store(in: &cancellables)
        } // forEach
        
        let data = UIImage(named: "placeholder")?.pngData()
        try XCTSkipIf(data != nil, "Data is nil!")
        downloadServiceMock.getImageWithSuccess(data!)
    }
    
    func testDownloadImageWithNoDataError() {
        sut.links.append(contentsOf: ["link1","link2","link3"])
        var onlyNoDataErrors = true
        
        let downloads = sut.downloadCatsImages(onRange: 0...0)
        downloads.forEach {
            $0.sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    switch error {
                    case .noData:
                        break
                    default:
                        onlyNoDataErrors = false
                    }
                }
            } receiveValue: { _ in
                onlyNoDataErrors = false
            }.store(in: &cancellables)
        } // forEach
        
        XCTAssert(onlyNoDataErrors)
        downloadServiceMock.getImageWithNoData()
    }
    
    func testDownloadImageWithInvalidURLError() {
        sut.links.append(contentsOf: ["link1","link2","link3"])
        var onlyInvalidURLErrors = true
        
        let downloads = sut.downloadCatsImages(onRange: 0...0)
        downloads.forEach {
            $0.sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        break
                    default:
                        onlyInvalidURLErrors = false
                    }
                }
            } receiveValue: { _ in
                onlyInvalidURLErrors = false
            }.store(in: &cancellables)
        } // forEach
        
        XCTAssert(onlyInvalidURLErrors)
        downloadServiceMock.getImageWithInvalidURL()
    }
    
    func testDownloadImageWithParsingError() {
        sut.links.append(contentsOf: ["link1","link2","link3"])
        var onlyParsingErrors = true
        
        let downloads = sut.downloadCatsImages(onRange: 0...0)
        downloads.forEach {
            $0.sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    switch error {
                    case .parsingError(error: _):
                        break
                    default:
                        onlyParsingErrors = false
                    }
                }
            } receiveValue: { _ in
                onlyParsingErrors = false
            }.store(in: &cancellables)
        } // forEach
        
        XCTAssert(onlyParsingErrors)
        downloadServiceMock.getImageWithParsingError(ErrorMock.error)
    }
    
    func testDownloadImageWithGenericError() {
        sut.links.append(contentsOf: ["link1","link2","link3"])
        var onlyGenericErrors = true
        
        let downloads = sut.downloadCatsImages(onRange: 0...0)
        downloads.forEach {
            $0.sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    switch error {
                    case .generic(error: _):
                        break
                    default:
                        onlyGenericErrors = false
                    }
                }
            } receiveValue: { _ in
                onlyGenericErrors = false
            }.store(in: &cancellables)
        } // forEach
        
        XCTAssert(onlyGenericErrors)
        downloadServiceMock.getImageWithGenericError(ErrorMock.error)
    }

}
