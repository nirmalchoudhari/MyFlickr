//
//  PhotosViewModelTests.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import XCTest
@testable import MyFlickr

class PhotosViewModelTests: XCTestCase {

    var sut: PhotosViewModel!

    override func setUpWithError() throws {
        sut = PhotosViewModel(networkService: MockNetworkService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPhotosVMMethods() {
        //Given mock data is used by URLService Mock from MockAPIResposne

        // Test fetch search esults
        let expctation = self.expectation(description: "test fetch search results")
        var results:[Photo]?
        sut.loadPhotos(for: "test", page: 1) { photos, _ in
            results = photos
            expctation.fulfill()
        }

        wait(for: [expctation], timeout: 5)
        XCTAssertNotNil(results, "api should return data")
        // test number of rows
        XCTAssertTrue(sut.numberOfPhotos != 0, "must have photos")
        XCTAssertTrue(sut.numberOfPhotos == 2, "must have two photos")


        XCTAssertFalse(sut.isNextPageAvailable, "must not have next page")

        guard let photo = sut.photo(for: IndexPath(row: 0, section: 0)) else {
            XCTFail("Should return a photo")
            return
        }
//        "id":"14722809396","owner":"126377022@N07","secret":"abd3e0b03c","server":"5592","farm":6,"title":"welchen die vier"
        XCTAssertEqual(photo.id, "14722809396" , "id should match")
        XCTAssertEqual(photo.owner, "126377022@N07" , "owner should match")
        XCTAssertEqual(photo.secret, "abd3e0b03c" , "secret should match")
        XCTAssertEqual(photo.server, "5592" , "server should match")
        XCTAssertEqual(photo.farm, 6 , "farm should match")
        XCTAssertEqual(photo.title, "welchen die vier" , "title should match")

        let photoUrl = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"

        XCTAssertEqual(photo.urlString(), photoUrl , "phot urls strings should match")

        sut.resetValues()

        XCTAssertFalse(sut.isNextPageAvailable, "must not have next page")
        XCTAssertTrue(sut.numberOfPhotos == 0, "must not have photos")

    }
}

