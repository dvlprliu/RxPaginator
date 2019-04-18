//
//  PaginatedList_.swift
//  ETURecord
//
//  Created by zhzh liu on 2019/4/17.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation

protocol PaginatedList_ {
    associatedtype Element
    associatedtype P: Paginator
    var hasMore: Bool { get set }
    var elements: [Element] { get set }
    var paginator: P { get set }
    
    static func empty() -> Self
    static func reduce(old list: Self, new: Self) -> Self
}

final class PagedList<E, P: Paginator>: PaginatedList_ {
    var hasMore: Bool
    var elements: [E]
    var paginator: P
    
    init(hasMore: Bool, elements: [E], paginator: P) {
        self.hasMore = hasMore
        self.elements = elements
        self.paginator = paginator
    }
    
    static func empty() -> PagedList {
        return PagedList<E, P>(hasMore: true, elements: [], paginator: P.initial)
    }
    
    static func reduce(old list: PagedList<E, P>, new: PagedList<E, P>) -> PagedList {
        return PagedList(
            hasMore: new.hasMore,
            elements: list.elements + new.elements,
            paginator: new.paginator
        )
    }
}
