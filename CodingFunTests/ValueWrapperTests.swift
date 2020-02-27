//
//  LSRTests.swift
//  CodingFun
//
//  Created by Paul Solt on 2/22/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import XCTest
import CodingFun

class ValueWrapperTests: XCTestCase {
    
    func testValueWrapper() {
        
        let value1 = ValueWrapper(key: "1", value: "One")
        
        XCTAssertEqual("1", value1.key)
        XCTAssertEqual("One", value1.value)
        
        let node1 = Node(value: value1)
        
        XCTAssertEqual("One", node1.value?.value)
        
        let value2 = ValueWrapper(key: "2", value: "Two")
        let node2 = Node(value: value2)
        
        XCTAssertNil(node1.next)
        XCTAssertNil(node2.next)
        
        node1.next = node2
        XCTAssertEqual(node2, node1.next)
        XCTAssertEqual(nil, node2.next)
        
        XCTAssertEqual("One", node1.value?.value)
        XCTAssertEqual("Two", node2.value?.value)
    }
    
}
