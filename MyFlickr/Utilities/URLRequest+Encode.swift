//
//  URLRequest+Encode.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import Foundation

/// URLRequest entenstion to encode the given query parameters 
extension URLRequest {
    // Shortcut - only supports get method to encode the query parameter. Other encoder can be input
    func encode(_ parameters: Parameters?) -> URLRequest {
        var request = self
        guard let url = url,
              let parameters = parameters,
              !parameters.isEmpty else { return request }
        if httpMethod == "GET" {
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return self
            }
            components.percentEncodedQuery = parameters.queryString()
            request.url = components.url
        }
        return request
    }

}
