//
//  MockNetworkService.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import Foundation
@testable import MyFlickr

class MockNetworkService: NetworkService {

    func execute(_ requestType: RequestType, responseQueue: DispatchQueue, completion: @escaping (APIResponse) -> Void) -> URLSessionTask? {
        responseQueue.async {
            switch requestType {

            case .search(_):
                completion(MockAPIResponse.validSearchResponseNoError())
            case .photo(_):
                completion(MockAPIResponse.validPhotoResponseNoError())
            }
            
        }
        return nil
    }
    
    func execute(_ requestType: RequestType, completion: @escaping (APIResponse) -> Void) -> URLSessionTask? {
        return execute(requestType, responseQueue: .main, completion: completion)
    }
    
    
}
