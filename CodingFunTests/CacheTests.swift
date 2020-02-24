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

}
