//
//  PaginatedList.swift
//  ETURecord
//
//  Created by zhzh liu on 2019/4/17.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation

protocol PaginatedList {
    associatedtype Element
    associatedtype P: Paginator
    var hasMore: Bool { get set }
    var elements: [Element] { get set }
    var paginator: P { get set }
    
    static func empty() -> Self
    static func reduce(old list: Self, new: Self) -> Self
}
