//
//  GeneralPagedList.swift
//  RxPaginator
//
//  Created by zhzh liu on 2019/4/18.
//

import Foundation

public final class PagedList<E, P: Paginator>: PaginatedListProcotol {
    public var hasMore: Bool
    public var elements: [E]
    public var paginator: P

    public init(hasMore: Bool, elements: [E], paginator: P) {
        self.hasMore = hasMore
        self.elements = elements
        self.paginator = paginator
    }

    public static func empty() -> PagedList {
        return PagedList<E, P>(hasMore: false, elements: [], paginator: P.initial)
    }

    public static func reduce(old list: PagedList<E, P>, new: PagedList<E, P>) -> PagedList {
        return PagedList(
                hasMore: new.hasMore,
                elements: list.elements + new.elements,
                paginator: new.paginator
        )
    }
}

extension PagedList: Equatable where E: Equatable, P: Equatable {
    public static func ==(lhs: PagedList, rhs: PagedList) -> Bool {
        return lhs.hasMore == rhs.hasMore &&
                lhs.elements == rhs.elements &&
                lhs.paginator == rhs.paginator
    }
}

extension PagedList: CustomStringConvertible {
    public var description: String {
        return "GeneralPagedList(hasMore: \(hasMore), elements: \(elements), paginator: \(paginator))"
    }
}

extension PagedList: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "List: \r { hasMore: \(hasMore), \r elements: [\(elements)], \r paginator: { \(paginator) \r }"
    }
}
