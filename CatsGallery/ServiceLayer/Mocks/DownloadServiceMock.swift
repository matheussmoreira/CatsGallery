//
//  DownloadServiceMock.swift
//  CatsGalleryTests
//
//  Created by Matheus Moreira on 18/07/23.
//

import Foundation

class DownloadServiceMock: DownloadServiceProtocol {
    var link: String?
    var getImageCompletion: ((Result<Data, NetworkError>) -> Void)?
    
    func getImage(link: String?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        getImageCompletion = completion
    }
    
    func getImageWithSuccess(_ data: Data) {
        getImageCompletion?(.success(data))
    }
    
    func getImageWithNoData() {
        getImageCompletion?(.failure(.noData))
    }
    
    func getImageWithInvalidURL() {
        getImageCompletion?(.failure(.invalidURL))
    }
    
    func getImageWithParsingError(_ error: Error) {
        getImageCompletion?(.failure(.parsingError(error: error)))
    }
    
    func getImageWithGenericError(_ error: Error) {
        getImageCompletion?(.failure(.generic(error: error)))
    }
}
