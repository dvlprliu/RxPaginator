//
//  SearchingPage.swift
//  ETURecord
//
//  Created by zhzh liu on 2019/4/17.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation

public struct SearchingPage {
    public let page: Page
    public let key: String?
    
    public init(page: Page, key: String?) {
        self.page = page
        self.key = key
    }
}

extension SearchingPage: Paginator {
    public static var initial: SearchingPage {
        return SearchingPage(page: Page.initial, key: nil)
    }
    
    public func first() -> SearchingPage {
        return SearchingPage(page: page.first(), key: key)
    }
    
    public func next() -> SearchingPage {
        return SearchingPage(page: self.page.next(), key: key)
    }
    
    public func previous() -> SearchingPage {
        return SearchingPage(page: self.page.previous(), key: key)
    }
}
