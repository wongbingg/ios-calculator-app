//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by 이원빈 on 2022/06/05.
//

import XCTest

class CalculatorUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_더하기() {
        let app = XCUIApplication()
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
    }
    
    func test_빼기() {
        let app = XCUIApplication()
        app.staticTexts["1"].tap()
        app.staticTexts["−"].tap()
        app.staticTexts["6"].tap()
        app.staticTexts["="].tap()
    }
    
    func test_곱하기() {
        let app = XCUIApplication()
        app.staticTexts["9"].tap()
        app.buttons["×"].tap()
        app.buttons["9"].tap()
        app.staticTexts["="].tap()
    }
    
    func test_나누기() {
        let app = XCUIApplication()
        app.buttons["2"].tap()
        app.buttons["7"].tap()
        app.staticTexts["÷"].tap()
        app.staticTexts["3"].tap()
        app.buttons["="].tap()
    }
    
    func test_나누기0일때_NaN오류를출력하는지() {
        let app = XCUIApplication()
        app.buttons["3"].tap()
        app.buttons["÷"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
    }
}
