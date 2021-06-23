//
//  PhotoImageCacheTests.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import XCTest
@testable import MyFlickr

class PhotoImageCacheTests: XCTestCase {

    var sut: PhotoImageCache!
    override func setUpWithError() throws {
        sut = PhotoImageCache()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testImageCache() {
        let cacheKey = "testCacheKey"
        guard let image = UIImage(named: "testImage", in: Bundle(for: Self.self), with: nil) else {
            XCTFail("add valid image in cache")
            return
        }
        sut.add(image, cacheKey: cacheKey)

        guard let cachedImage = sut.image(cacheKey) else {
            XCTFail("valid image should be present in cache")
            return
        }
        XCTAssertEqual(image, cachedImage, "saved and fetched image should be the same")
    }

}
