//
//  SRDemoAppTests.swift
//  SRDemoAppTests
//
//  Created by Rick Windham on 9/4/14.
//  Copyright (c) 2014 Swift Time. All rights reserved.
//

import XCTest
import SwiftlyReachable

class SRDemoAppTests: XCTestCase {
    
    var reachability:STReachability! = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        reachability = STReachability()
    }
    
    override func tearDown() {
        reachability = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChangedBlock() {
        let expect = self.expectationWithDescription("changeBlock")
        reachability.changedBlock = {status in
            expect.fulfill()
        }
        // this test requires manually changing
        // the network, hence the 60 second wait time.
        reachability.startMonitor()
        self.waitForExpectationsWithTimeout(60, nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
