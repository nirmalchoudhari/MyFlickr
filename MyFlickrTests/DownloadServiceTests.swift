//
//  DownloadServiceTests.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import XCTest
@testable import MyFlickr

class DownloadServiceTests: XCTestCase {

    var sut: ImageDownloadService!

    override func setUpWithError() throws {
        sut = ImageDownloadService(with: MockNetworkService(), cache: PhotoImageCache())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchSearchResult() {
        let expectation = self.expectation(description: "load search")
        var photoResult: UIImage?

        sut.loadImage("hhtp://test.com/photo") { response in
            switch response {
            case .result(let image): photoResult = image
            default: break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(photoResult, "api should return vallid image")
    }
}
