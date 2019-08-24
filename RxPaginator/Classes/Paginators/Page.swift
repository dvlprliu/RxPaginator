//
//  Page.swift
//  ETURecord
//
//  Created by zhzh liu on 4/16/19.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation

public struct Page {
    public let num: Int

    public init(num: Int = 0) {
        self.num = num
    }
}

extension Page: Paginator {
    
    public static var initial: Page {
        return Page(num: 1)
    }
    
    public func first() -> Page {
        return Page(num: 1)
    }
    
    public func next() -> Page {
        return Page(num: num + 1)
    }
    
    public func previous() -> Page {
        return Page(num: num - 1)
    }
}

extension Page: Equatable {
    public static func ==(lhs: Page, rhs: Page) -> Bool {
        return lhs.num == rhs.num
    }
}
