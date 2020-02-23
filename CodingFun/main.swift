//
//  main.swift
//  CodingFun
//
//  Created by Paul Solt on 2/22/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation

// LRU Cache

//Value type 'Node' cannot have a stored property that recursively contains it

class ValueWrapper<T: AnyObject>: Equatable where T: Equatable {
    static func == (lhs: ValueWrapper<T>, rhs: ValueWrapper<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    var value: T
    var node: Node<T>?
//    var date: Date?
    
    init(value: T) {
        self.value = value
    }
}

class Node<T: AnyObject>: Equatable where T: Equatable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    var next: Node?
    var prev: Node?
    
    weak var value: ValueWrapper<T>?
    
    init(value: ValueWrapper<T>) {
        self.value = value
    }
}

class LinkedList<T: AnyObject> where T: Equatable {
    var head: Node<T>?
    var tail: Node<T>?
    
    func insertAtHead(node: Node<T>) {
        node.next = head
        
        if tail == head {
            tail = node
        }
        head = node
    }
    
    func remove(node: Node<T>) {
        
        // if tail, set tail to previous
    }
    
    func moveToFront(node: Node<T>) {
        remove(node: node)
        insertAtHead(node: node)
        
        // TODO: if tail, set tail to 2nd to last
    }
    
    func removeAll() {
        // TODO: will this leak memory if we remove the head nodes
        
        head = nil
        tail = nil
    }
}

class Cache<T: AnyObject> where T: Equatable {
    // Least Recently Used
    
    var store: [String : ValueWrapper<T>]
    var recentQueue: LinkedList<T>
    
    init() {
        store = [:]
        recentQueue = LinkedList()
    }
    
    func valueFor(key: String) -> ValueWrapper<T>? {
        let value = store[key]
        if value != nil, let node = value?.node {
            // TODO: move to front of the recent queue
            recentQueue.moveToFront(node: node)
        }
        return store[key]
    }
    
    func insertValue(value: T, for key: String) {
        let value = ValueWrapper(value: value)
        let node = Node(value: value)
        value.node = node
        store[key] = value
        
        recentQueue.insertAtHead(node: node)
        // TODO: insert into front of queue
    }
    
    func removeAll() {
        store.removeAll()
        recentQueue.removeAll()
    }
}

