//
//  SearchServiceMock.swift
//  CatsGalleryTests
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

class SearchServiceMock: SearchServiceProtocol {
    var getPostsCompletion: ((Result<APIResponse, NetworkError>) -> Void)?
    
    func getPosts(completion: @escaping (Result<APIResponse, NetworkError>) -> Void) {
        self.getPostsCompletion = completion
    }
    
    // MARK: Simulated requests
    
    func getPostsWithSuccess(_ response: APIResponse) {
        getPostsCompletion?(.success(response))
    }
    
    func getPostsWithNoData() {
        getPostsCompletion?(.failure(.noData))
    }
    
    func getPostsWithInvalidURL() {
        getPostsCompletion?(.failure(.invalidURL))
    }
    
    func getPostsWithParsingError(_ error: Error) {
        getPostsCompletion?(.failure(.parsingError(error: error)))
    }
    
    func getPostsWithGenericError(_ error: Error) {
        getPostsCompletion?(.failure(.generic(error: error)))
    }
}
