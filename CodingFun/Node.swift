//
//  Node.swift
//  CodingFun
//
//  Created by Paul Solt on 2/24/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation


class Node<T> {
    var next: Node?
    weak var prev: Node?
    var value: ValueWrapper<T>?
    
    init(value: ValueWrapper<T>) {
        self.value = value
    }
}

extension Node: Equatable where T: Equatable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
}
