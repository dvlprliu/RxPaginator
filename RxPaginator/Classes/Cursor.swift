//
//  Cursor.swift
//  ETURecord
//
//  Created by zhzh liu on 2019/4/17.
//  Copyright © 2019 ETUSchool. All rights reserved.
//

import Foundation

struct Cursor {
    let minPosition: String?
    let maxPosition: String?
    
    init(minPosition: String?, maxPosition: String?) {
        self.minPosition = minPosition
        self.maxPosition = maxPosition
    }
}

extension Cursor: Paginator {
    static var initial: Cursor {
        return Cursor(minPosition: nil, maxPosition: nil)
    }
    
    func first() -> Cursor {
        return Cursor(
            minPosition: nil,
            maxPosition: nil
        )
    }
    
    func next() -> Cursor {
        return Cursor(
            minPosition: self.maxPosition,
            maxPosition: self.maxPosition
        )
    }
    
    func previous() -> Cursor {
        return Cursor(
            minPosition: self.minPosition,
            maxPosition: self.minPosition
        )
    }
}

extension Cursor: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(minPosition)
        hasher.combine(maxPosition)
    }

    public static func ==(lhs: Cursor, rhs: Cursor) -> Bool {
        if lhs.minPosition != rhs.minPosition {
            return false
        }
        if lhs.maxPosition != rhs.maxPosition {
            return false
        }
        return true
    }
}