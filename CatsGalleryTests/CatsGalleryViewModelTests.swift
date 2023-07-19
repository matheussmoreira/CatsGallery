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
//        sut = CatsGalleryViewModel(searchService: searchServiceMock as! SearchServiceProtocol,
//                                   downloadService: downloadServiceMock! as! DownloadServiceProtocol)
    }

    override func tearDownWithError() throws {
        sut = nil
        searchServiceMock = nil
        downloadServiceMock = nil
        cancellables = nil
    }
    
    func testQueryPostsWithSuccess() {
        sut.queryPosts { }.sink { completion in
            switch completion {
            case .finished:
                break
            default:
                XCTFail("Request should have succeeded!")
            }
        } receiveValue: { _ in
            XCTAssert(true)
        }.store(in: &cancellables)
        
        var postData = PostData()
        postData.id = "QualquerCoisa"
        let response = APIResponse(data: [postData], success: true, status: 200)
        
        searchServiceMock.getPostsWithSuccess(response)
    }
}
