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
        XCTAssertFalse(app.navigationBars["Star Gazers List"].exists)

//        let contentView = app.otherElements["contentView"]
//        XCTAssertTrue(contentView.exists)
//
//        let titleLabel = app.staticTexts["titleLable"]
//        XCTAssertTrue(titleLabel.exists)
//        XCTAssertEqual(titleLabel.label, "Starred repository")
//
//        let repoNameLabel = app.staticTexts["repoNameLable"]
//        XCTAssertTrue(repoNameLabel.exists)
//        XCTAssertEqual(repoNameLabel.label, "Repository name")
//
//        let repoOwnerLabel = app.staticTexts["repoOwnerLabel"]
//        XCTAssertTrue(repoOwnerLabel.exists)
//        XCTAssertEqual(repoOwnerLabel.label, "Owner")
//
//        let repoNameTextField = app.textFields["repoNameTextField"]
//        XCTAssertTrue(repoNameTextField.exists)
//        XCTAssertEqual(repoNameTextField.label, "")
//        XCTAssertEqual(repoNameTextField.placeholderValue, "Insert repository name")
//
//        let repoOwnerTextField = app.textFields["repoOwnerTextField"]
//        XCTAssertTrue(repoOwnerTextField.exists)
//        XCTAssertEqual(repoOwnerTextField.label, "")
//        XCTAssertEqual(repoOwnerTextField.placeholderValue, "Insert repository owner")
//
//        let confirmButton = app.buttons["confirmButton"]
//        XCTAssertTrue(confirmButton.exists)
//        XCTAssertEqual(confirmButton.label, "Confirm")
    }

//    func testInsertRepoName() {
//        let repoNameTextField = app.textFields["repoNameTextField"]
//        repoNameTextField.tap()
//        repoNameTextField.typeText(testRepoName)
//
//        guard let text = repoNameTextField.value as? String else {
//            XCTFail()
//            return
//
//        }
//        XCTAssertEqual(text, testRepoName)
//        XCTAssertEqual(repoNameTextField.placeholderValue, "Insert repository name")
//
//        let confirmButton = app.buttons["confirmButton"]
//        confirmButton.tap()
//
//        let errorAlert = app.alerts["Error"]
//        XCTAssertTrue(errorAlert.exists)
//        XCTAssertFalse(errorAlert.description.isEmpty)
//    }
}

