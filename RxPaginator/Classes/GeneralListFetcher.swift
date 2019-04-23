//
//  GeneralListFetcher.swift
//  RxPaginator
//
//  Created by zhzh liu on 2019/4/18.
//

import Foundation
import RxCocoa
import RxSwift

class GeneralListFetcher<List: PaginatedList>: ListFetcherProtocol {
    typealias P = List.P
    // interactions
    let refresh: AnyObserver<Void>
    let loadmore: AnyObserver<Void>
    // states
    let list: Driver<List>
    let loading: Driver<Bool>
    let errors: Driver<Error>
    var current: List = List.empty()
    // private
    private let bag = DisposeBag()

    init(request: @escaping (P) -> Observable<List>) {
        let refreshSubject = PublishSubject<Void>()
        let loadMoreSubject = PublishSubject<Void>()
        let listSubject = BehaviorSubject<List>(value: List.empty())
        let activityIndicator = ActivityIndicator()
        let errorSubject = PublishSubject<Error>()

        refresh = refreshSubject.asObserver()
        loadmore = loadMoreSubject.asObserver()
        list = listSubject.asDriver(onErrorDriveWith: .empty()).skip(1)
        loading = activityIndicator.asDriver()
        errors = errorSubject.asDriver(onErrorDriveWith: .empty())

        let requestClosure: (P) -> Observable<List> = { paginator in
            request(paginator)
                    .trackActivity(activityIndicator)
                    .catchError { error in
                        errorSubject.onNext(error)
                        return .empty()
                    }
        }

        let refreshResult = refreshSubject
                .withLatestFrom(listSubject) { _, list in
                    list.paginator.first()
                }
                .flatMapLatest(requestClosure)

        let loadMoreResult = loadMoreSubject
                .filterNot(activityIndicator.asObservable())
                .filter(listSubject.map {
                    $0.hasMore
                })
                .withLatestFrom(listSubject) { _, list in
                    list.paginator.next()
                }
                .flatMapLatest(requestClosure)
                .withLatestFrom(listSubject, resultSelector: { new, old in
                    List.reduce(old: old, new: new)
                })

        Observable.merge([refreshResult, loadMoreResult])
                .do(onNext: { [weak self] list in
                    self?.current = list
                })
                .bind(to: listSubject)
                .disposed(by: bag)
    }
}