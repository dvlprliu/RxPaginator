//
//  Page.swift
//  ETURecord
//
//  Created by zhzh liu on 4/16/19.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation

struct Page {
    let num: Int

    init(num: Int = 0) {
        self.num = num
    }
    
}

extension Page: Paginator {
    
    static var initial: Page {
        return Page(num: 1)
    }
    
    func first() -> Page {
        return Page(num: 1)
    }
    
    func next() -> Page {
        return Page(num: num + 1)
    }
    
    func previous() -> Page {
        return Page(num: num - 1)
    }
}

extension Page: Equatable {
    static func ==(lhs: Page, rhs: Page) -> Bool {
        return lhs.num == rhs.num
    }
}