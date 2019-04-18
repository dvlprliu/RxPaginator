//
//  SearchingPage.swift
//  ETURecord
//
//  Created by zhzh liu on 2019/4/17.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation

struct SearchingPage {
    let page: Page
    let key: String?
    
    init(page: Page, key: String?) {
        self.page = page
        self.key = key
    }
}

extension SearchingPage: Paginator {
    static var initial: SearchingPage {
        return SearchingPage(page: Page.initial, key: nil)
    }
    
    func first() -> SearchingPage {
        return SearchingPage(page: page.first(), key: key)
    }
    
    func next() -> SearchingPage {
        return SearchingPage(page: self.page.next(), key: key)
    }
    
    func previous() -> SearchingPage {
        return SearchingPage(page: self.page.previous(), key: key)
    }
}
