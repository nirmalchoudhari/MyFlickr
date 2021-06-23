//
//  ResponseParserTests.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import XCTest
@testable import MyFlickr

class CustomTestCase<T>: XCTestCase {}

class ResponseParserTests: CustomTestCase<SearchResult> {
    
    var sut: ResponseParser<SearchResult>!
    
    override func setUpWithError() throws {
        sut = ResponseParser<SearchResult>()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testParseValidResposneNoError() {
        // Given
        let apiResposne = MockAPIResponse.validSearchResponseNoError()
        // When
        let response = sut.handleResposne(apiResposne)
        
        // Then
        XCTAssertNotNil(response, "Response should not be nil")
        switch response {
        case .result(let result):
            XCTAssertNotNil(result, "Response should not be empty")
        case .error(let error):
            XCTAssertNil(error, "There should be no error")
        }
    }

    func testParseInValidResposneAPIError() {
        // Given
        let apiResposne = MockAPIResponse.invalidResposneAPIError()
        // When
        let response = sut.handleResposne(apiResposne)

        // Then
        XCTAssertNotNil(response, "Response should not be nil")
        switch response {
        case .result(let result):
            XCTAssertNil(result, "Result should not be nil")
        case .error(let error):
            XCTAssertNotNil(error, "There should be an error")
            XCTAssertTrue(error == APIError.fetchFailed(MockError.networkFail), "Network Fail error should occour")
        }
    }

    func testParseInValidResposneSerelizationError() {
        // Given
        let apiResposne = MockAPIResponse.invalidResponseSerelizationError()
        // When
        let response = sut.handleResposne(apiResposne)
        
        // Then
        XCTAssertNotNil(response, "Response should not be nil")
        switch response {
        case .result(let result):
            XCTAssertNil(result, "Result should not be nil")
        case .error(let error):
            XCTAssertNotNil(error, "There should be an error")
            XCTAssertTrue(error == APIError.serelization, "Serialization error should occour")
        }
    }
    
    func testParseInValidResposneNoData() {
        // Given
        let apiResposne = MockAPIResponse.invalidResposneNoData()
        // When
        let response = sut.handleResposne(apiResposne)
        
        // Then
        XCTAssertNotNil(response, "Response should not be nil")
        switch response {
        case .result(let result):
            XCTAssertNil(result, "Result should not be nil")
        case .error(let error):
            XCTAssertNotNil(error, "There should be an error")
            XCTAssertTrue(error == APIError.noData, "Nodata error should occour")
        }
    }
    
}
