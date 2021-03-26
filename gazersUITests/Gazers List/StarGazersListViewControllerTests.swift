//
//  StarGazersListViewControllerTests.swift
//  gazersUITests
//
//  Created by Nicolò Pasini on 25/03/21.
//

import XCTest

class StarGazersListViewControllerTests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()

        app.launchArguments = ["-UITesting", "true"]
        app.launchEnvironment = ["testPage": "starGazerList"]

        app.launch()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppearance() throws {
        XCTAssert(app.navigationBars["Star Gazers List"].exists)

        let tableView = app.tables["gazersTableView"]
        XCTAssertTrue(tableView.exists)
        XCTAssertEqual(tableView.cells.count, 25)

        let messageView = app.otherElements["messageView"]
        XCTAssertFalse(messageView.exists)

        let messageLabel = app.staticTexts["messageLabel"]
        XCTAssertFalse(messageLabel.exists)

        for index in 0..<tableView.cells.count {
            let cell = app.cells["DataCell\(index)"].firstMatch
            let text = cell.staticTexts.element(matching:.any, identifier: "gazerName")
            XCTAssertEqual(text.label, "Test\(index + 1)")
        }
    }

    func testLoadNewData() throws {
        XCTAssert(app.navigationBars["Star Gazers List"].exists)

        let tableView = app.tables["gazersTableView"]

        tableView.swipeUp()

        while !app.cells["DataCell24"].firstMatch.isHittable {
            tableView.swipeUp()
        }

        XCTAssertEqual(tableView.cells.count, 30)

        for index in 0..<tableView.cells.count {
            let cell = app.cells["DataCell\(index)"].firstMatch
            let text = cell.staticTexts.element(matching:.any, identifier: "gazerName")
            XCTAssertEqual(text.label, "Test\(index + 1)")
        }
    }
}

