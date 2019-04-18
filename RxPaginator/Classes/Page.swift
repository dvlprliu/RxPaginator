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
    
    init(page: Int = 0) {
        self.num = page
    }
    
}

extension Page: Paginator {
    
    static var initial: Page {
        return Page(page: 1)
    }
    
    func first() -> Page {
        return Page(page: 1)
    }
    
    func next() -> Page {
        return Page(page: num + 1)
    }
    
    func previous() -> Page {
        return Page(page: num - 1)
    }
}
