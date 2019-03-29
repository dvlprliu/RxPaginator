//
//  PaginatedRequest.swift
//  RxPaginator
//
//  Created by zhzh liu on 3/29/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol PaginatedRequest {
    func factory(page: Page) -> Self
    func data() -> Observable<Data>
}
