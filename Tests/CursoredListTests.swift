//
// Created by zhzh liu on 2019-04-23.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import RxPaginator

class CursoredListTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_Initialize() {
        let cursor = Cursor(minPosition: "asdf", maxPosition: "qwer")
        let list = PagedList(
                hasMore: true,
                elements: [TestModel](),
                paginator: cursor
        )
        XCTAssertTrue(list.hasMore)
        XCTAssertTrue(list.elements.isEmpty)
        XCTAssertEqual(list.paginator.minPosition, "asdf")
        XCTAssertEqual(list.paginator.maxPosition, "qwer")
    }

    func test_Empty() {
        let emptyList = PagedList<TestModel, Cursor>.empty()
        XCTAssertTrue(emptyList.hasMore)
        XCTAssertTrue(emptyList.elements.isEmpty)
        XCTAssertNil(emptyList.paginator.minPosition)
        XCTAssertNil(emptyList.paginator.maxPosition)
    }

    func test_Reduce() {
        let fstPage = Cursor(minPosition: nil, maxPosition: nil)
        let fstElements = ListTestsHelper.models(count: 10)
        let fstList = PagedList(
                hasMore: true,
                elements: fstElements,
                paginator: fstPage
        )

        let sndPage = Cursor(minPosition: "asdf", maxPosition: "qwer")
        let sndElements = ListTestsHelper.models(count: 10)
        let sndList = PagedList(
                hasMore: false,
                elements: sndElements,
                paginator: sndPage
        )

        let reducedList = PagedList<TestModel, Cursor>.reduce(old: fstList, new: sndList)

        XCTAssertFalse(reducedList.hasMore)
        XCTAssertEqual(reducedList.elements, fstElements + sndElements)
        XCTAssertEqual(reducedList.paginator.minPosition, "asdf")
        XCTAssertEqual(reducedList.paginator.maxPosition, "qwer")
    }
}
