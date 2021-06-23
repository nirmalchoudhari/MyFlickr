//
//  MockAPIResponse.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import Foundation
import UIKit.UIImage

@testable import MyFlickr

enum MockError: Error, Equatable {
    case networkFail
    static func == (lhs: MockError, rhs: MockError) -> Bool {
        switch (lhs, rhs) {
        case (.networkFail, .networkFail): return true
        }
    }
}

class MockAPIResponse {
    
    static func validSearchResponseNoError() -> APIResponse {
        let jsonString = #"{"photos":{"page":1,"pages":1,"perpage":100,"total":2,"photo":[{"id":"14722809396","owner":"126377022@N07","secret":"abd3e0b03c","server":"5592","farm":6,"title":"welchen die vier","ispublic":1,"isfriend":0,"isfamily":0},{"id":"1030378384","owner":"60004356@N00","secret":"4a8cd73e9d","server":"1393","farm":2,"title":"Ibiza","ispublic":1,"isfriend":0,"isfamily":0}]},"stat":"ok"}"#
        let data = Data(jsonString.utf8)
        return APIResponse(data: data, error: nil)
    }

    static func invalidResponseSerelizationError() -> APIResponse  {
        let jsonString = #"{"photos":{"page":1,"pages":1,"perpage":100,"total":2,"photo":[{"id":"14722809396","owner":"126377022@N07","secret":"abd3e0b03c","server":"5592","farm":6,"title":"welchen die vier","ispublic":1,"isfriend":0,"isfamily":0},{"id":"1030378384","owner":"60004356@N00","secret":"4a8cd73e9d","server":"1393","farm":null,"title":"Ibiza","ispublic":1,"isfriend":0,"isfamily":0}]},"stat":"ok"}"#
        let data = Data(jsonString.utf8)
        return APIResponse(data: data, error: nil)
    }

    static func validPhotoResponseNoError() -> APIResponse {
        let image = UIImage(named: "testImage", in: Bundle(for: Self.self), with: nil)
        let data = image?.pngData()
        return APIResponse(data: data, error: nil)
    }

    static func invalidResposneAPIError () -> APIResponse  {
        return APIResponse(data: nil, error: MockError.networkFail)
    }
    
    static func invalidResposneNoData () -> APIResponse  {
        return APIResponse(data: nil, error: nil)
    }
}
