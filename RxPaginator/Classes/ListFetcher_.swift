//
//  ListFetcher_.swift
//  ETURecord
//
//  Created by zhzh liu on 2019/4/17.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ListFetcher_ {
    associatedtype List: PaginatedList_
    var refresh: AnyObserver<Void> { get }
    var loadmore: AnyObserver<Void> { get }
    
    var list: Driver<List> { get }
    var loading: Driver<Bool> { get }
    var errors: Driver<Error> { get }
    var current: List { get }
}

class GeneralListFetcher<List: PaginatedList_>: ListFetcher_ {
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
            .withLatestFrom(listSubject) { _, list in list.paginator.first() }
            .flatMapLatest(requestClosure)
        
        let loadMoreResult = loadMoreSubject
            .filterNot(activityIndicator.asObservable())
            .filter(listSubject.map { $0.hasMore })
            .withLatestFrom(listSubject) { _, list in list.paginator.next() }
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
