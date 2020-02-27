//
//  CacheTests.swift
//  CodingFunTests
//
//  Created by Paul Solt on 2/24/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import XCTest

class CacheTests: XCTestCase {
    
    func testCache() {
        let cache = Cache<String>(maxSize: 5)
        
        cache.insertValue(value: "One", for: "1")
        cache.insertValue(value: "Two", for: "2")
        cache.insertValue(value: "Three", for: "3")
        cache.insertValue(value: "Four", for: "4")
        cache.insertValue(value: "Five", for: "5")
        
        XCTAssertEqual("One", cache.valueFor(key: "1"))
        XCTAssertEqual("Two", cache.valueFor(key: "2"))
        XCTAssertEqual("Three", cache.valueFor(key: "3"))
        XCTAssertEqual("Four", cache.valueFor(key: "4"))
        XCTAssertEqual("Five", cache.valueFor(key: "5"))
    }
    
    func testCacheRemovesLastElementOverMaxSize() {
        let cache = Cache<String>(maxSize: 5)
        
        cache.insertValue(value: "One", for: "1")
        cache.insertValue(value: "Two", for: "2")
        cache.insertValue(value: "Three", for: "3")
        cache.insertValue(value: "Four", for: "4")
        cache.insertValue(value: "Five", for: "5")
        
        XCTAssertEqual("One", cache.valueFor(key: "1"))
        XCTAssertEqual("Two", cache.valueFor(key: "2"))
        XCTAssertEqual("Three", cache.valueFor(key: "3"))
        XCTAssertEqual("Four", cache.valueFor(key: "4"))
        XCTAssertEqual("Five", cache.valueFor(key: "5"))
        XCTAssertNil(cache.valueFor(key: "6"))
        
        cache["6"] = "six";
        
        XCTAssertEqual("six", cache["6"])
        XCTAssertNil(cache["1"])
        
        cache["7"] = "seven";
        
        XCTAssertEqual("seven", cache["7"])
        XCTAssertNil(cache["2"])
    }
    
    func testNodeValueWrapperDoesNotCreateARetainCycle() {
        var value: ValueWrapper? = ValueWrapper(key: "1", value: "One")
        var node: Node? = Node(value: value!)
        value?.node = node
        
        weak var weakValue = value
        weak var weakNode = node
        
        // Clearing the references should cause the memory to clean up if there
        // isn't a retain cycle between the two objects
        value = nil
        node = nil
        
        XCTAssertNil(weakValue)
        XCTAssertNil(weakNode)
    }
    
    func testCacheFreeMemoryAfterRemoveAll() {
        // Cache any object to verify its memory is cleared
        let cache = Cache<NumberFormatter>(maxSize: 5)
        var value: NumberFormatter? = NumberFormatter()
        
        weak var weakValue = value
        
        cache["test"] = value
        
        value = nil
        cache.removeAll()
        
        XCTAssertNil(weakValue)
    }
}
