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

extension GeneralPagedList: Equatable where E: Equatable, P: Equatable {
    static func ==(lhs: GeneralPagedList, rhs: GeneralPagedList) -> Bool {
        return lhs.hasMore == rhs.hasMore &&
                lhs.elements == rhs.elements &&
                lhs.paginator == rhs.paginator
    }
}

extension GeneralPagedList: CustomStringConvertible {
    public var description: String {
        return "GeneralPagedList(hasMore: \(hasMore), elements: \(elements), paginator: \(paginator))"
    }
}

extension GeneralPagedList: CustomDebugStringConvertible {
    var debugDescription: String {
        return "List: \r { hasMore: \(hasMore), \r elements: [\(elements)], \r paginator: { \(paginator) \r }"
    }
}
