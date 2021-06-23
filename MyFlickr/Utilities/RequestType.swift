//
//  RequestType.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import Foundation

typealias Parameters = [String: Any]

/// Enum which represent Request Type
enum RequestType {
    case search(Parameters)
    case photo(String)

    var baseURL: String {
        switch self {
        case .search:
            return "https://api.flickr.com/services/rest/"
        case .photo(let urlString):
            return urlString
        }
    }

    var parameters: Parameters? {
        switch self {
        case .search(let params):
            return params
        case .photo:
            return nil
        }
    }

    var httpMentod: String {
        switch self {
        case .search,
             .photo:
            return "GET"
        }
    }

    func asURLRequest() -> URLRequest {
        guard let url = URL(string: baseURL) else {
            fatalError("cannot load the url from baseURL string")
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMentod
        return request.encode(parameters)
    }
}
