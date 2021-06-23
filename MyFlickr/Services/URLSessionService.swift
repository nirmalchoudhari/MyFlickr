//
//  URLService.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import Foundation

/// Protocol for Network Service which can be implemented and injected
protocol NetworkService {
    @discardableResult
    func execute(_ requestType: RequestType, responseQueue: DispatchQueue, completion: @escaping (APIResponse) -> Void) -> URLSessionTask?
    @discardableResult
    func execute(_ requestType: RequestType, completion: @escaping (APIResponse) -> Void) -> URLSessionTask?
}

/// Enum to represent API resposne
struct APIResponse {
    let data: Data?
    let error: Error?
}

/// NetworkService implementation using URLSession
final class URLSessionService: NetworkService {
    
    private let defaultSession: URLSession
    private var dataTask: URLSessionDataTask?

    init(session: URLSession = URLSession(configuration: .default)) {
        defaultSession = session
    }
    /// Initializer
    /// - Parameter session: oprional session value. If not provided, uses a default session
//    init(configuration: URLSessionConfiguration = .default) {
//        defaultSession = URLSession(configuration: configuration)
//    }
    /// Executes the API request based on the request type
    /// - Parameters:
    ///   - requestType: a request type for a request
    ///   - completion: completion handler returning APIResposne
    @discardableResult
    func execute(_ requestType: RequestType, completion: @escaping (APIResponse) -> Void) -> URLSessionTask? {
        return execute(requestType, responseQueue: .main, completion: completion)
    }
    
    /// Executes the API request based on the request type
    /// - Parameters:
    ///   - requestType: a request type for a request
    ///   - responseQueue: A dispatch queue on which resposne is requested, defaults to main queue
    ///   - completion: completion handler returning APIResposne
    @discardableResult
    func execute(_ requestType: RequestType, responseQueue: DispatchQueue, completion: @escaping (APIResponse) -> Void) -> URLSessionTask? {
        dataTask?.cancel()
        let urlRequest = requestType.asURLRequest()
        dataTask = defaultSession.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            let apiResponse = APIResponse(data: data, error: error)
            responseQueue.async {
                completion(apiResponse)
            }
        })

        dataTask?.resume()
        return dataTask
    }
}
