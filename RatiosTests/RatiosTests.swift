//
//  RatiosTests.swift
//  RatiosTests
//
//  Created by James Pamplona on 1/25/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import XCTest
@testable import Ratios

class RatiosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFormatDecimalNumbersForAccessibility() {
        XCTAssertEqual("The number is 123.56".formatDecimalNumbersForAccessibility(), "The number is 123 point 56")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
