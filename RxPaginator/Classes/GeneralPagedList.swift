//
//  GeneralPagedList.swift
//  RxPaginator
//
//  Created by zhzh liu on 2019/4/18.
//

import Foundation

final class GeneralPagedList<E, P: Paginator>: PaginatedList {
    var hasMore: Bool
    var elements: [E]
    var paginator: P
    
    init(hasMore: Bool, elements: [E], paginator: P) {
        self.hasMore = hasMore
        self.elements = elements
        self.paginator = paginator
    }
    
    static func empty() -> GeneralPagedList {
        return GeneralPagedList<E, P>(hasMore: true, elements: [], paginator: P.initial)
    }
    
    static func reduce(old list: GeneralPagedList<E, P>, new: GeneralPagedList<E, P>) -> GeneralPagedList {
        return GeneralPagedList(
            hasMore: new.hasMore,
            elements: list.elements + new.elements,
            paginator: new.paginator
        )
    }
}

