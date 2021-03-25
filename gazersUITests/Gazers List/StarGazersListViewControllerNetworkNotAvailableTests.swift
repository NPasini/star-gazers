//
//  StarGazersListViewControllerNetworkNotAvailableTests.swift
//  gazersUITests
//
//  Created by Nicolò Pasini on 25/03/21.
//

import XCTest

class StarGazersListViewControllerNetworkNotAvailableTests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()

        app.launchArguments = ["-UITesting", "true", "-networkNotAvailable", "true"]
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
        XCTAssertEqual(tableView.cells.count, 0)
    }
}

