//
//  NYCSchoolsUITests.swift
//  NYCSchoolsUITests
//
//  Created by Muthu Sabarinathan on 7/26/22.
//

import XCTest

class NYCSchoolsUITests: XCTestCase {

    func testUIFlowFromListToDetail() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.tables.staticTexts["Liberation Diploma Plus High School"].exists)
        app.tables.staticTexts["Liberation Diploma Plus High School"].tap()
        
        let label = app.tables.staticTexts["LIBERATION DIPLOMA PLUS"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(app.tables.staticTexts["LIBERATION DIPLOMA PLUS"].exists)
        
    }
}
