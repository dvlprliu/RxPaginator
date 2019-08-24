//
//  Paginator.swift
//  ETURecord
//
//  Created by zhzh liu on 2019/4/17.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation

public protocol Paginator {
    static var initial: Self { get }
    func first() -> Self
    func next() -> Self
    func previous() -> Self
}
