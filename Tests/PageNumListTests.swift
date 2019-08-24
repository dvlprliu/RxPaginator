//
// Created by zhzh liu on 2019-04-23.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import RxPaginator

class PageNumListTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_Initialize() {
        let page = Page(num: 0)
        let list = PagedList(
                hasMore: true,
                elements: [TestModel](),
                paginator: page
        )
        XCTAssertEqual(list.hasMore, true)
        XCTAssertEqual(list.elements.isEmpty, true)
        XCTAssertEqual(list.paginator.num, page.num)
    }

    func test_Empty() {
        let list = PagedList<TestModel, Page>.empty()
        XCTAssertTrue(list.hasMore)
        XCTAssertTrue(list.elements.isEmpty)
        XCTAssertEqual(list.paginator.num, 1)
    }

    func test_Reduce() {
        // Given
        let page1 = Page(num: 1)
        let page1Models = ListTestsHelper.models(count: 10)
        let list1 = PagedList(
                hasMore: true,
                elements: page1Models,
                paginator: page1
        )
        let page2 = Page(num: 2)
        let page2Models = ListTestsHelper.models(count: 10)
        let list2 = PagedList(
                hasMore: false,
                elements: page2Models,
                paginator: page2
        )
        // When
        let reducedList = PagedList<TestModel, Page>.reduce(old: list1, new: list2)
        // Then
        XCTAssertFalse(reducedList.hasMore)
        XCTAssertEqual(reducedList.elements.count, page1Models.count + page2Models.count)
        XCTAssertEqual(reducedList.elements, page1Models + page2Models)
        XCTAssertEqual(reducedList.paginator.num, 2)
    }

}
