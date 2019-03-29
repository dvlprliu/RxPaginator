//
//  PaginatedListFetcher.swift
//  RxPaginator
//
//  Created by zhzh liu on 3/29/19.
//

import Foundation
import RxCocoa
import RxSwift

public class PaginatedListFetcher<List: PaginatedList>: ListFetcher {
    
    public let refresh: AnyObserver<Void>
    public let loadmore: AnyObserver<Void>
    
    public let list: Driver<List>
    public let loading: Driver<Bool>
    public let errors: Driver<Error>
    public var transform: ((Data, List) -> Observable<List>)?
    
    private var _current: List = List.empty()
    public var current: List { return _current }
    private let bag = DisposeBag()
    
    init(request: PaginatedRequest) {
        let refreshSubject = PublishSubject<Void>()
        let loadMoreSubject = PublishSubject<Void>()
        let listSubject = ReplaySubject<List>.create(bufferSize: 1)
        let activityIndicator = ActivityIndicator()
        let errorSubject = PublishSubject<Error>()
        
        refresh = refreshSubject.asObserver()
        loadmore = loadMoreSubject.asObserver()
        loading = activityIndicator.asDriver()
        errors = errorSubject.asDriver(onErrorDriveWith: .empty())
        list = listSubject.asDriver(onErrorDriveWith: .empty())
        
        let requestClosure: (Page) -> Observable<List> = { page in
            return request.factory(page: page).data()
                .flatMapLatest { [weak self] (json) -> Observable<List> in
                    guard let strongSelf = self else { return .empty() }
                    return strongSelf.transform(json: json)
                }
                .trackActivity(activityIndicator)
                .catchError { error in
                    errorSubject.onNext(error)
                    return .empty()
                }
        }
        
        let refreshResult = refreshSubject
            .flatMapLatest { [weak self] in
                requestClosure(self?.current.page ?? List.empty().page)
        }
        
        let loadMoreResult = loadMoreSubject.asObservable()
            .filterNot(loading.asObservable())
            .filter(listSubject.map { $0.hasMore })
            .withLatestFrom(listSubject)
            .flatMapLatest { requestClosure($0.page.next()) }
            .withLatestFrom(listSubject) { new, old in
                List.reduce(old: old, new: new)
            }
        
        Observable.merge([refreshResult, loadMoreResult])
            .do(onNext: { [weak self] list in
                self?._current = list
            })
            .bind(to: listSubject)
            .disposed(by: bag)
    }
    
    public func transform(json: Data) -> Observable<List> {
        return self.transform?(json, current) ?? .empty()
    }
}
