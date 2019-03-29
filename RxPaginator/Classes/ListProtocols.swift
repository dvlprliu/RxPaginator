//
//  ListProtocols.swift
//  RxPaginator
//
//  Created by zhzh liu on 3/29/19.
//

import Foundation

public protocol RemoteList {
    associatedtype T
    var hasMore: Bool { get set }
    var elements: [T] { get set }
    
    static func empty() -> Self
    static func reduce(old list: Self, new: Self) -> Self
}

public protocol PaginatedList: RemoteList {
    var page: Page { get set }
}
