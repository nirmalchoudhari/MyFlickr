//
//  ImageParserTests.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import XCTest
@testable import MyFlickr

class ImageParserTests: XCTestCase {

    var sut: ImageResposneParser!

    override func setUpWithError() throws {
        sut = ImageResposneParser()

    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testParseValidResposneNoError() {
        // Given
        let apiResposne = MockAPIResponse.validPhotoResponseNoError()
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
            XCTAssertNil(result, "Photo should not be nil")
        case .error(let error):
            XCTAssertNotNil(error, "There should be an error")
            XCTAssertTrue(error == APIError.fetchFailed(MockError.networkFail), "Network Fail error should occour")
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
            XCTAssertNil(result, "Photo should not be nil")
        case .error(let error):
            XCTAssertNotNil(error, "There should be an error")
            XCTAssertTrue(error == APIError.noData, "Nodata error should occour")
        }
    }

}
