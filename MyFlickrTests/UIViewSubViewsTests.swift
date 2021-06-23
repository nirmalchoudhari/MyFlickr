//
//  UIViewSubViewsTests.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import XCTest
@testable import MyFlickr

class UIViewSubViewsTests: XCTestCase {

    var sut: UIView!
    override func setUpWithError() throws {
        sut = UIView()
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testSubviewsOfGivenType() throws {

        let label1 = UILabel()
        let label2 = UILabel()
        sut.addSubview(label1)
        sut.addSubview(label2)

        let button1 = UIButton()
        sut.addSubview(button1)

        let totalLabelsInView = sut.allSubViews(UILabel.self).count
        let totalButtonsInView = sut.allSubViews(UIButton.self).count
        XCTAssertEqual(totalLabelsInView, 2 , "View has 2 Labels")
        XCTAssertEqual(totalButtonsInView, 1 , "View has 1 Button")

    }
}
