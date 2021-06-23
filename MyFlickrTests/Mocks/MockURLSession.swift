//
//  MockURLSession.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import Foundation

typealias SessionResposne = (data:Data?, res:URLResponse?, err:Error?)
typealias SessionCompletion = (SessionResposne) -> Void

class MockURLSession: URLSession {
    var resposne: SessionResposne?
    override func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionTask { [weak self] in
            completionHandler(self?.resposne?.data, self?.resposne?.res, self?.resposne?.err)
        }
    }
}
