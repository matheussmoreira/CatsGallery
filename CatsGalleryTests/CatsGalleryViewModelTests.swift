//
//  CatsGalleryViewModelTests.swift
//  CatsGalleryTests
//
//  Created by Matheus Moreira on 17/07/23.
//

import XCTest
import Combine
@testable import CatsGallery

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
    
    func testSearchPostsWithSuccess() {
        sut.searchCatsPosts { }.sink { completion in
            switch completion {
            case .finished:
                break
            default:
                XCTFail("Request should have succeeded!")
            }
        } receiveValue: { _ in
            XCTAssertFalse(self.sut.links.isEmpty)
            XCTAssert(true)
        }.store(in: &cancellables)
        
        let imageDataMock = ImageData(id: "", title: "", description: "", datetime: 0, animated: false, width: 0, height: 0, size: 0, views: 0, bandwidth: 0, vote: nil, favorite: true, nsfw: nil, section: nil, accounturl: nil, accountid: nil, isAd: false, inMostViral: false, hasSound: true, tags: nil, adType: 2, adurl: "", edited: "", inGallery: false, link: "link", commentCount: nil, favoriteCount: nil, ups: nil, downs: nil, points: nil, score: nil)
        
        let postDataMock = PostData(id: "id", title: "title", description: nil, datetime: 1234, cover: "cover", coverWidth: 1, coverHeight: 1, accounturl: "url", accountid: 1, privacy: "privacy", layout: "layout", views: 0, link: "link", ups: 2, downs: 2, points: 0, score: 0, isAlbum: false, vote: nil, favorite: true, nsfw: false, section: "section", commentCount: 6, favoriteCount: 4, topic: nil, topicid: nil, imagesCount: 4, inGallery: false, isAd: false, tags: [], adType: 4, adurl: "url", inMostViral: false, includeAlbumAds: false, images: [imageDataMock], adConfig: nil)
        
        let response = APIResponse(data: [postDataMock], success: true, status: 200)
        
        searchServiceMock.getPostsWithSuccess(response)
    }
}
