//
//  Cache.swift
//  CodingFun
//
//  Created by Paul Solt on 2/22/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation

// Least Recently Used Cache
class Cache<T: Any> where T: Equatable, T: CustomStringConvertible {
    
    var store: [String : ValueWrapper<T>]
    var recentQueue: LinkedList<T>
    
    private var maxSize: Int
    
    init(maxSize: Int) {
        self.maxSize = maxSize
        self.store = [:]
        self.recentQueue = LinkedList()
    }
    
    func valueFor(key: String) -> T? {
        let value = store[key]
        if value != nil, let node = value?.node {
            recentQueue.moveToFront(node: node)
        }
        return store[key]?.value
    }

    subscript(key: String) -> T? {
        get {
            return valueFor(key: key)
        }
        set {
            guard let newValue = newValue else { return }
            insertValue(value: newValue, for: key)
        }
    }
    
    func updateValue(_ value: T, forKey key: String) {
        insertValue(value: value, for: key)
    }
    
    func insertValue(value: T, for key: String) {
        let value = ValueWrapper(key: key, value: value)
        let node = Node(value: value)
        value.node = node
        
        store[key] = value
        recentQueue.insert(node)

        if store.count > maxSize {
            removeLast()
        }
    }
    
    func removeLast() {
        if let node = recentQueue.tail {
            if let key = node.value?.key {
                store.removeValue(forKey: key)
                // TODO: remove reference to value
            }            
            recentQueue.removeLast()
        }
    }
    
    func removeAll() {
        store.removeAll()
        recentQueue.removeAll()
    }
    
    func count() -> Int {
        return store.count
    }
}

