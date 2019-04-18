//
//  ListFetcher_.swift
//  ETURecord
//
//  Created by zhzh liu on 2019/4/17.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ListFetcherProtocol {
    associatedtype List: PaginatedList
    var refresh: AnyObserver<Void> { get }
    var loadmore: AnyObserver<Void> { get }
    
    var list: Driver<List> { get }
    var loading: Driver<Bool> { get }
    var errors: Driver<Error> { get }
    var current: List { get }
}
