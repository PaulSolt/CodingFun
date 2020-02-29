//
//  LinkedListTests.swift
//  CodingFunTests
//
//  Created by Paul Solt on 2/24/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import XCTest

class LinkedListTests: XCTestCase {

    func testLinkedListInsertAtHead() {
        let list = LinkedList<String>()
        let n1 = Node(value: ValueWrapper(key: "1", value: "One"))
        let n2 = Node(value: ValueWrapper(key: "2", value: "Two"))
        let n3 = Node(value: ValueWrapper(key: "3", value: "Three"))
        
        list.insert(n1)
        
        // n1
        XCTAssertNil(n1.next)
        XCTAssertNil(n1.prev)
        XCTAssertEqual(n1, list.head)
        XCTAssertEqual(n1, list.tail)
        
        list.insert(n2)
        
        // n2 -> n1
        XCTAssertEqual(n1, n2.next)
        XCTAssertNil(n1.next)
        XCTAssertEqual(n2, n1.prev)
        XCTAssertNil(n2.prev)
        XCTAssertEqual(n1, list.tail)
        XCTAssertEqual(n2, list.head)
        
        list.insert(n3)
        
        // n3 -> n2 -> n1
        XCTAssertEqual(n3, list.head)
        XCTAssertEqual(n2, list.head?.next)
        XCTAssertEqual(n1, list.head?.next?.next)
        XCTAssertNil(list.head?.next?.next?.next)
        
        XCTAssertEqual(n2, n1.prev)
        XCTAssertEqual(n3, n2.prev)
        XCTAssertNil(n3.prev)
        
        XCTAssertEqual(n1, list.tail)
        list.printList()
    }
    
    func testLinkedListRemoveHeadUpdatesHeadToNext() {
        let list = LinkedList<String>()
        let n1 = Node(value: ValueWrapper(key: "1", value: "One"))
        let n2 = Node(value: ValueWrapper(key: "2", value: "Two"))
        let n3 = Node(value: ValueWrapper(key: "3", value: "Three"))
        
        list.insert(n1)
        list.insert(n2)
        list.insert(n3)
        
        // n3 -> n2 -> n1
        
        list.remove(n1)
        
        XCTAssertEqual(n3, list.head)
        XCTAssertEqual(n2, list.tail)
    }
    
    func testLinkedListRemoveTailChangesTailToPrevious() {
        let list = LinkedList<String>()
        let n1 = Node(value: ValueWrapper(key: "1", value: "One"))
        let n2 = Node(value: ValueWrapper(key: "2", value: "Two"))
        let n3 = Node(value: ValueWrapper(key: "3", value: "Three"))
        
        list.insert(n1)
        list.insert(n2)
        list.insert(n3)
        
        // head | n3 -> n2 -> n1 | tail

        list.remove(n1)
        
        XCTAssertEqual(n2, list.tail) // new tail
        XCTAssertNil(n2.next)
        
        list.remove(n2)
        
        XCTAssertEqual(n3, list.tail) // new tail
        XCTAssertNil(n3.next)
        
        list.remove(n3)
        XCTAssertNil(list.tail)
        XCTAssertNil(list.head)
    }
    
    func testLinkedListRemoveHeadChangesHeadToNext() {
        
        let list = LinkedList<String>()
        let n1 = Node(value: ValueWrapper(key: "1", value: "One"))
        let n2 = Node(value: ValueWrapper(key: "2", value: "Two"))
        let n3 = Node(value: ValueWrapper(key: "3", value: "Three"))
        
        // head | n3 -> n2 -> n1 | tail
        
        list.insert(n1)
        list.insert(n2)
        list.insert(n3)
        
        list.remove(n3)
        
        XCTAssertEqual(n2, list.head) // new head
        XCTAssertNil(n2.prev)
        
        list.remove(n2)
        
        XCTAssertEqual(n1, list.head) // new head
        XCTAssertNil(n1.prev)
        
        list.remove(n1)
        
        XCTAssertNil(list.tail)
        XCTAssertNil(list.head)
    }
    
    func testLinkedListRemoveCenterUpdatesPrevAndNext() {
        
        let list = LinkedList<String>()
        let n1 = Node(value: ValueWrapper(key: "1", value: "One"))
        let n2 = Node(value: ValueWrapper(key: "2", value: "Two"))
        let n3 = Node(value: ValueWrapper(key: "3", value: "Three"))
        
        list.insert(n1)
        list.insert(n2)
        list.insert(n3)
        
        // n3 -> n2 -> n1
        
        list.remove(n2)
        
        XCTAssertEqual(n1, n3.next)
        XCTAssertEqual(n3, n1.prev)
        
        XCTAssertEqual(n3, list.head)
        XCTAssertEqual(n1, list.tail)
    }
    
    func testRemoveAllClearsMemory() {
        let list = LinkedList<String>()
        var n1: Node? = Node(value: ValueWrapper(key: "1", value: "One"))
        var n2: Node? = Node(value: ValueWrapper(key: "2", value: "Two"))
        var n3: Node? = Node(value: ValueWrapper(key: "3", value: "Three"))
        
        weak var weakN1 = n1
        weak var weakN2 = n2
        weak var weakN3 = n3
        
        // head | n3 -> n2 -> n1 | tail
        
        list.insert(n1!)
        list.insert(n2!)
        list.insert(n3!)

        n1 = nil // Remove ownership from local variables
        n2 = nil
        n3 = nil
        
        list.removeAll() // clearing list should cleanup all nodes
        
        XCTAssertNil(weakN1)
        XCTAssertNil(weakN2)
        XCTAssertNil(weakN3)
        
        XCTAssertNil(list.head)
        XCTAssertNil(list.tail)
    }
    
    func testRemoveLastClearsMemory() {
        let list = LinkedList<String>()
        var n1: Node? = Node(value: ValueWrapper(key: "1", value: "One"))
        var n2: Node? = Node(value: ValueWrapper(key: "2", value: "Two"))
        var n3: Node? = Node(value: ValueWrapper(key: "3", value: "Three"))
        
        weak var weakN1 = n1
        weak var weakN2 = n2
        weak var weakN3 = n3
        
        // head | n3 -> n2 -> n1 | tail
        
        list.insert(n1!)
        list.insert(n2!)
        list.insert(n3!)

        n1 = nil // Remove ownership from local variables
        n2 = nil
        n3 = nil
        
        while (list.head != nil) {
            list.removeLast()
        }
        
        XCTAssertNil(weakN1)
        XCTAssertNil(weakN2)
        XCTAssertNil(weakN3)
        
        XCTAssertNil(list.head)
        XCTAssertNil(list.tail)
    }

}
