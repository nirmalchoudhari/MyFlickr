//
//  URLSessionServiceTests.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import XCTest
@testable import MyFlickr

class URLSessionServiceTests: XCTestCase {
    
    var sut: URLSessionService!

    override func setUpWithError() throws {
        let reposne: SessionResposne = (data: MockAPIResponse.validSearchResponseNoError().data, res:nil, err:nil)
        let session = MockURLSession() // Kept this deprecation as not breaking anything
        session.resposne = reposne
        sut = URLSessionService(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testExecuteAPI() {
        let expectation = self.expectation(description: "Testing URL Session")
        var responseData: Data?
        let parameters: [String : Any] = ["method": "flickr.photos.search",
                          "api_key": Constants.apiKey,
                          "format": "json",
                          "nojsoncallback": 1,
                          "safe_search": 1,
                          "text": "test"]
        sut.execute(.search(parameters)) { (response) in
            responseData = response.data
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 4)
        XCTAssertNotNil(responseData, "api should return data")
    }
    
}
