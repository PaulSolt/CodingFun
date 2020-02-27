//
//  LinkedList.swift
//  CodingFun
//
//  Created by Paul Solt on 2/24/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation

class LinkedList<T: Any> where T: Equatable, T: CustomStringConvertible {
    private (set) var head: Node<T>?
    private (set) var tail: Node<T>?
    
    func insert(_ node: Node<T>) {
        if head == nil { // insert head
            node.prev = nil
            node.next = nil
            head = node
            tail = node
        } else { // update head
            node.prev = nil
            node.next = head
            head?.prev = node
            head = node
        }
    }
    
    func remove(_ node: Node<T>) {
        if head == node && tail == node {
            head = nil
            tail = nil
        } else if head == node {
            head = node.next
            head?.prev = nil
        } else if tail == node {
            tail = node.prev
            tail?.next = nil
        } else {
            let previous = node.prev
            let next = node.next
            previous?.next = next
            next?.prev = previous
        }
    }
    
    func moveToFront(node: Node<T>) {
        remove(node)
        insert(node)
    }
    
    func removeAll() {
        var node = head
        while (node != nil) {
            let current = node
            node = node?.next
            
            current?.prev = nil
            current?.next = nil
        }
        
        head = nil
        tail = nil
    }
    
    func removeLast() {
        if let tail = tail {
            remove(tail)
        }
    }
    
    func printList() {
        var node = head
        print("head: \(String(describing: head?.value))")
        while node != nil {
            print(node?.value ?? "nil")
            node = node?.next
        }
    }
}
