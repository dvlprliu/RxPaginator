//
// Created by zhzh liu on 2019-04-23.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation

class ListTestsHelper {
    static func models(count: Int) -> [TestModel] {
        return (0..<count).map(TestModel.init)
    }
}