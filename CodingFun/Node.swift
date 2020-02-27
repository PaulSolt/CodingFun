//
//  Node.swift
//  CodingFun
//
//  Created by Paul Solt on 2/24/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation


class Node<T: Any>: Equatable where T: Equatable, T: CustomStringConvertible {
    
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    var next: Node?
    weak var prev: Node?
    
    var value: ValueWrapper<T>?
    
    init(value: ValueWrapper<T>) {
        self.value = value
    }
}
