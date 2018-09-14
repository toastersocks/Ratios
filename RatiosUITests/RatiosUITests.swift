//
//  RatiosUITests.swift
//  RatiosUITests
//
//  Created by James Pamplona on 9/7/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import XCTest

class RatiosUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSubstanceLabelNames() {
        
        let app = XCUIApplication()
        let leftsiderationameTextField = app/*@START_MENU_TOKEN@*/.textFields["leftSideRatioName"]/*[[".otherElements[\"Elements for specifying your desired ratio of THC to CBD\"]",".textFields[\"x\"]",".textFields[\"leftSideRatioName\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        leftsiderationameTextField.tap()
        leftsiderationameTextField.typeText("xLabel")
        guard let leftSideText = leftsiderationameTextField.value as? String else { XCTFail("Could not get value of leftsiderationameTextField"); return }
        print("leftSideText: \(leftSideText)")
        let desiredthctextfieldTextField = app/*@START_MENU_TOKEN@*/.textFields["desiredTHCTextField"]/*[[".otherElements[\"Elements for specifying your desired ratio of THC to CBD\"].textFields[\"desiredTHCTextField\"]",".textFields[\"desiredTHCTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        desiredthctextfieldTextField.tap()
        desiredthctextfieldTextField.typeText("1")
        
        let rightsiderationameTextField = app/*@START_MENU_TOKEN@*/.textFields["rightSideRatioName"]/*[[".otherElements[\"Elements for specifying your desired ratio of THC to CBD\"]",".textFields[\"y\"]",".textFields[\"rightSideRatioName\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        rightsiderationameTextField.tap()
        rightsiderationameTextField.typeText("yLabel")
        
        let desiredcbdtextfieldTextField = app/*@START_MENU_TOKEN@*/.textFields["desiredCBDTextField"]/*[[".otherElements[\"Elements for specifying your desired ratio of THC to CBD\"].textFields[\"desiredCBDTextField\"]",".textFields[\"desiredCBDTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        desiredcbdtextfieldTextField.tap()
        desiredcbdtextfieldTextField.typeText("1")
        app/*@START_MENU_TOKEN@*/.buttons["nextButton"]/*[[".buttons[\"Next\"]",".buttons[\"nextButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let aLeftSideSubstanceName = app.staticTexts[leftSideText]
        print("aLeftSideSubstanceName: \(aLeftSideSubstanceName.value as! String)")
        XCTAssertTrue(app.staticTexts[leftSideText].exists)
        /*
        guard let leftSideSubstanceLabelText = aLeftSideSubstanceName.value as? String else { XCTFail("Could not get value of aLeftSideSubstanceName"); return }
        print("leftSideSubstanceLabelText: \(leftSideSubstanceLabelText)")
        XCTAssertEqual(leftSideText, leftSideSubstanceLabelText, "The xPercentageName of substance A should be equal to the xLabel of entered on the left side substance on the Ratio view")
        */
        
    }

}
