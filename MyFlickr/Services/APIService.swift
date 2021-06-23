//
//  APIService.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import Foundation

/// Enum representing API Errors
enum APIError: LocalizedError, Equatable {
    case noData
    case serelization
    case fetchFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .noData:
            return Constants.noDataAvaialble
        case .serelization:
            return Constants.serilizationError
        case .fetchFailed(let error):
            return error.localizedDescription
        }
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData): return true
        case (.serelization, .serelization): return true
        case (.fetchFailed(let lhsError), .fetchFailed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default: return false
        }
    }
}

/// Enum representing APIService result for View Models
enum APIServiceResult<T> {
    case result(T)
    case error(APIError)
}

/// API Service layee which used given network service to call network http requests
final class APIService {
    
    private var urlSessionService: NetworkService
    
    init(with urlSessionService: NetworkService) {
        self.urlSessionService = urlSessionService
    }
    
    /// API to fetch search results
    /// - Parameter completion: Completion Handler
    func fetchSearchResult(_ searchKey: String, page: Int, completion: @escaping (APIServiceResult<SearchResult>) -> Void) {
        let parameters: [String : Any] = ["method": "flickr.photos.search",
                          "api_key": Constants.apiKey,
                          "format": "json",
                          "nojsoncallback": 1,
                          "safe_search": 1,
                          "text": searchKey,
                          "page": "\(page)"]
        urlSessionService.execute(.search(parameters)) { response in
            let result = ResponseParser<SearchResult>().handleResposne(response)
            completion(result)
        }
    }

}
