//
//  ListFetcher.swift
//  RxPaginator
//
//  Created by zhzh liu on 3/29/19.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ListFetcher {
    associatedtype List: RemoteList
    var refresh: AnyObserver<Void> { get }
    var loadmore: AnyObserver<Void> { get }
    
    var list: Driver<List> { get }
    var loading: Driver<Bool> { get }
    var errors: Driver<Error> { get }
    var isEmpty: Driver<Bool> { get }
    var current: List { get }
    
    func transform(json: Data) -> Observable<List>
}

public extension ListFetcher {
    var isEmpty: Driver<Bool> {
        return list.map { $0.elements.isEmpty }
    }
}
