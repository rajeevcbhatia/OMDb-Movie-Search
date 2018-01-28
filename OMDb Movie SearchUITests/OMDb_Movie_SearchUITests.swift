//
//  OMDb_Movie_SearchUITests.swift
//  OMDb Movie SearchUITests
//
//  Created by Rajeev Bhatia on 23/01/18.
//  Copyright © 2018 rajeev. All rights reserved.
//

import XCTest
@testable import OMDb_Movie_Search

class OMDb_Movie_SearchUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchPopupShownForEmptyTerm() {
        
        app.buttons["Go!"].tap()
        XCTAssert(app.alerts[OMSStrings.noSearchTermTitle].exists, "no search term alert not shown")

    }
    
    func testSearchResultsArePopulated() {
        
        app.textFields["searchTextField"].typeText("godfather")
        app.buttons["Go!"].tap()
        sleep(3)
        XCTAssert(app.tables.cells.count > 0, "no items loaded in table")
        
    }
    
    func testItemDetailIsShown() {
        
        app.textFields["searchTextField"].typeText("godfather")
        app.buttons["Go!"].tap()
        sleep(3)
        XCTAssert(app.tables.cells.count > 0, "no items loaded in table")
        app.tables.cells.element(boundBy: 0).tap()
        
        sleep(2)
        //assert that image has been loaded
        XCTAssert(app.images.count == 1, "image not loaded")
        //assert that type, title and summary have been loaded
        XCTAssert(app.staticTexts.count == 3, "type, title or plot not loaded")
    }
    
}
