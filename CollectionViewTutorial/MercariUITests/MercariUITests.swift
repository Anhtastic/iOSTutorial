//
//  MercariUITests.swift
//  MercariUITests
//
//  Created by Anh Doan on 6/20/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import XCTest
@testable import Mercari

class MercariUITests: XCTestCase {
    
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNameShown() {
        // Use recording to get started writing UI tests.
        XCTAssert(app.staticTexts["men1"].exists) // Selecting the first item name to se if it's displayed correctly.
    }
    
    func testPriceShown() {
        XCTAssert(app.textFields["$51"].exists) // Selecting the first item price to see if it's displayed correctly.
    }    

}
