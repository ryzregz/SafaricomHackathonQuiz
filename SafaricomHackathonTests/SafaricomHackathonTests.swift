//
//  SafaricomHackathonTests.swift
//  SafaricomHackathonTests
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import XCTest
@testable import SafaricomHackathon

class SafaricomHackathonTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testApiDataLoad(){
        let ex = expectation(description: "Expecting a response data not nil")
        let category = ""
        let type = ""
        ApiServiceClient.client_instance.sendNewsRequest(type:type,category:category,onSuccess: {(r) in
            XCTAssertNotNil(r)
            ex.fulfill()
        }, onError: {(e)
            in
            XCTAssertNil(e)
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }

}
