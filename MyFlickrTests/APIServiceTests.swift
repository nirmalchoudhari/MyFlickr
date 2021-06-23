//
//  APIServiceTests.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import XCTest
@testable import MyFlickr

class APIServiceTests: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {
        sut = APIService(with: MockNetworkService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFetchSearchResult() {
        let expectation = self.expectation(description: "load search")
        var searchResult: SearchResult?
        sut.fetchSearchResult("test", page: 1) { response in
            switch response {
            case .result(let res): searchResult = res
            default: break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
        XCTAssertNotNil(searchResult, "api should return photos result")
    }
}
