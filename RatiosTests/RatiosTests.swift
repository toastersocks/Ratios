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
    
    func testStateTransformerRatioToStrainsTransformation() {
        let ratioState = RatioViewController.State(xRatio: "1",
                                                   yRatio: "1",
                                                   xLabel: "XLabel",
                                                   yLabel: "YLabel",
                                                   grams: nil)
        var stateTransformer = StateTransformer(currentState: .ratio(state: ratioState))
        let substanceState = stateTransformer.next(with: ratioState)
        print("substanceState.xPercentageName: \(substanceState.xPercentageName)")
        print("ratioState.xLabel: \(ratioState.xLabel)")
        XCTAssertEqual(substanceState.xPercentageName, ratioState.xLabel, "The xPercentageName of a substanceState should be equal to the xLabel of the ratioState it was derived from")
        XCTAssertEqual(substanceState.yPercentageName, ratioState.yLabel, "The yPercentageName of a substanceState should be equal to the yLabel of the ratioState it was derived from")
    }
    
}
