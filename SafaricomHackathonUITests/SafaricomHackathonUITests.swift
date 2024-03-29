//
//  SafaricomHackathonUITests.swift
//  SafaricomHackathonUITests
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import XCTest

class SafaricomHackathonUITests: XCTestCase {

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

    func testTabBarSwitching() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["SOURCES"].tap()
        tabBarsQuery.buttons["ALL NEWS"].tap()
        
        
        
    }
    
    func testOnboarding(){
        let app = XCUIApplication()
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        nextButton.tap()
        app.buttons["Done"].tap()
        
    }
    
    func testRefreshButtonTap(){
        XCUIApplication().navigationBars["News"].buttons["Refresh"].tap()

    }

}
