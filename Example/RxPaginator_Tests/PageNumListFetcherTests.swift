//
// Created by zhzh liu on 2019-04-23.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import RxPaginator

typealias PageNumList = GeneralPagedList<TestModel, Page>

class PageNumListFetcherTests: XCTestCase {

    var disposeBag: DisposeBag?
    var fetcher: GeneralListFetcher<PageNumList>!
    var scheduler = TestScheduler(initialClock: 0)
    lazy var observer = self.scheduler.createObserver(PageNumList.self)

    override func setUp() {
        super.setUp()
        fetcher = GeneralListFetcher<PageNumList> { (p: Page) -> Observable<PageNumList> in
            return .just(PageNumListGenerator.list(page: p.num, hasMore: p.num != 5, count: 1))
        }
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_refreshThenLoadMore() {

        let refreshEvents = scheduler.createHotObservable(
                [
                    .next(5, ())
                ]
        )
        let loadMoreEvents = scheduler.createHotObservable(
                [
                    .next(10, ()),
                    .next(20, ()),
                    .completed(25)
                ]
        )

        refreshEvents.bind(to: fetcher.refresh)
                .disposed(by: disposeBag!)

        loadMoreEvents.bind(to: fetcher.loadmore)
                .disposed(by: disposeBag!)

        fetcher.list
                .drive(observer)
                .disposed(by: disposeBag!)

        let res = scheduler.start {
            loadMoreEvents.asObservable()
        }

        let fstLst = PageNumListGenerator.list(page: 1, count: 1)
        let sndLst = PageNumListGenerator.list(page: 2, count: 1)
        let thirdLst = PageNumListGenerator.list(page: 3, count: 1)

        let fstReduced = PageNumList.reduce(old: fstLst, new: sndLst)
        let sndReduced = PageNumList.reduce(old: fstReduced, new: thirdLst)

        let correctValues: [Recorded<Event<PageNumList>>] = [
            .next(5, fstLst),
            .next(10, fstReduced),
            .next(20, sndReduced)
        ]

        XCTAssertEqual(observer.events, correctValues)
    }

}

class PageNumListGenerator {
    static func list(page: Int, hasMore: Bool = true, count: Int) -> PageNumList {
        let lower = (page - 1) * count
        let upper = lower + count
        let range = lower..<upper
        let models = range.map(TestModel.init)
        return PageNumList(
                hasMore: hasMore,
                elements: models,
                paginator: Page(num: page)
        )
    }
}