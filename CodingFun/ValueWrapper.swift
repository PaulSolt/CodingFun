//
//  ValueWrapper.swift
//  CodingFun
//
//  Created by Paul Solt on 2/24/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation

class ValueWrapper<T: Any>: Equatable, CustomStringConvertible where T: Equatable, T: CustomStringConvertible {
    
    static func == (lhs: ValueWrapper<T>, rhs: ValueWrapper<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    var key: String
    var value: T
    weak var node: Node<T>?
    
    init(key: String, value: T) {
        self.key = key
        self.value = value
    }
    
    var description: String {
        return value.description
    }
}
