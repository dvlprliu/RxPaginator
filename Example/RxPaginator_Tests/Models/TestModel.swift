//
// Created by zhzh liu on 2019-04-23.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation

struct TestModel: Hashable {
    let value: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }

    static func ==(lhs: TestModel, rhs: TestModel) -> Bool {
        return lhs.value == rhs.value
    }
}

extension TestModel: CustomStringConvertible {
    public var description: String {
        return "(value: \(value))"
    }
}
