//
//  CursorTests.swift
//  RxPaginator_Tests
//
//  Created by zhzh liu on 2019/4/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import RxPaginator

class CursorTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func test_CursorInit() {
        let cursor = Cursor(minPosition: "minPosition", maxPosition: "maxPosition")
        XCTAssertEqual("minPosition", cursor.minPosition)
        XCTAssertEqual("maxPosition", cursor.maxPosition)
    }

    func test_CursorInitial() {
        let cursor = Cursor.initial
        XCTAssertNil(cursor.minPosition)
        XCTAssertNil(cursor.maxPosition)
    }

    func test_CursorFirst() {
        let cursor = Cursor(minPosition: "minPosition", maxPosition: "maxPosition")
        let first = cursor.first()
        XCTAssertNil(first.minPosition)
        XCTAssertNil(first.maxPosition)
    }

}
