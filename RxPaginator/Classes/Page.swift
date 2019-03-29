//
//  Page.swift
//  RxPaginator
//
//  Created by zhzh liu on 3/29/19.
//

import Foundation

public struct Page {
    let page: Int
    let size: Int
    
    init(page: Int = 1, size: Int = 10) {
        self.page = page
        self.size = size
    }
    
    func first() -> Page {
        return Page(page: 1, size: size)
    }
    
    func next() -> Page {
        return Page(page: page + 1, size: size)
    }
}
