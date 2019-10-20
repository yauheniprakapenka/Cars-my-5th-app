//
//  carsUITests.swift
//  carsUITests
//
//  Created by yauheni prakapenka on 20/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import XCTest

let app = XCUIApplication()

class carsUITests: XCTestCase {
    
    let uiTestHelper = UITestHelper()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
    }

    func testExample() {
        
        let tablesQuery = app.tables.cells
        
        app.buttons["Add"].tap()
        sleep(1)
        app.tables.textFields["Введите год"].tap()
        uiTestHelper.enterDataInTheField(string: "2009")
        
        sleep(1)
        uiTestHelper.tapOnCoordinate(at: 16, and: 100)
        app.buttons["Автоматически"].tap()
        
        sleep(1)
        app.tables.textFields["Введите производителя"].tap()
        uiTestHelper.enterDataInTheField(string: "Cat corporation")
        
        sleep(1)
        uiTestHelper.tapOnCoordinate(at: 16, and: 100)
        app.buttons["Автоматически"].tap()
        
        sleep(1)
        app.swipeUp()
        app.tables.textFields["Введите модель"].tap()
        uiTestHelper.enterDataInTheField(string: "Maynkun")
        
        sleep(1)
        app.swipeUp()
        app.tables.textFields["Введите кузов"].tap()
        uiTestHelper.enterDataInTheField(string: "Fat")
        
        sleep(1)
        app.buttons["Сохранить"].tap()
        
        sleep(1)
        app.staticTexts["BMW 5 E39"].tap()
        app.tables.textFields["BMW"].tap()
        
        for _ in 0...2 { app.keys["delete"].tap() }
        uiTestHelper.enterDataInTheField(string: "Ural")
        uiTestHelper.tapOnCoordinate(at: 16, and: 100)
        app.buttons["Автоматически"].tap()
        
        sleep(1)
        app.buttons["Сохранить"].tap()
        
        sleep(1)
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        
        sleep(1)
        tablesQuery.element(boundBy: 2).swipeLeft()
        tablesQuery.element(boundBy: 2).buttons["Delete"].tap()
        
        sleep(1)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
