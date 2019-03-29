//
//  Observable+Operators.swift
//  ETURecord
//
//  Created by zhzh liu on 2018/1/15.
//  Copyright © 2018年 ETUSchool. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {
    
    func filter<O: ObservableType>(_ predicate: O) -> Observable<E> where O.E == Bool {
        return self
            .withLatestFrom(predicate) { element, predicate in (element, predicate) }
            .filter { _, predicate in predicate }
            .map { element, _ in element }
    }
    
    func filterNot<O: ObservableType>(_ predicate: O) -> Observable<E> where O.E == Bool {
        return self
            .withLatestFrom(predicate) { element, predicate in (element, predicate) }
            .filter { _, predicate in !predicate }
            .map { element, _ in element }
    }
}

extension SharedSequence {
    
    func filter<O: SharedSequenceConvertibleType>(_ predicate: O) -> SharedSequence<S, E> where O.E == Bool, O.SharingStrategy == S {
        return withLatestFrom(predicate) { element, predicate in (element, predicate) }
            .filter { _, predicate in predicate }
            .map { element, _ in element }
    }
    
    func filterNot<O: SharedSequenceConvertibleType>(_ predicate: O) -> SharedSequence<S, E> where O.E == Bool, O.SharingStrategy == S {
        return withLatestFrom(predicate) { element, predicate in (element, predicate) }
            .filter { _, predicate in !predicate }
            .map { element, _ in element }
    }
    
}

