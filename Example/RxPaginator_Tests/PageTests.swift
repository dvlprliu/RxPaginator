//
//  PageTests.swift
//  RxPaginator_Tests
//
//  Created by zhzh liu on 2019/4/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import RxPaginator

class PageTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func test_that_PageInit() {
        let page = Page(num: 1)
        XCTAssertEqual(1, page.num)
    }

    func test_PageNext() {
        let page = Page(num: 1)
        let nextPage = page.next()
        XCTAssertEqual(nextPage.num, 1 + 1)
    }

    func test_PagePrevious() {
        let page = Page(num: 3)
        let prePage = page.previous()
        XCTAssertEqual(prePage.num, 3 - 1)
    }

    func test_PageFirst() {
        let page = Page(num: 4)
        let firstPage = page.first()
        XCTAssertEqual(firstPage.num, 1)
    }

    func test_PageInitial() {
        let page = Page.initial
        XCTAssertEqual(page.num, 1)
    }

}
