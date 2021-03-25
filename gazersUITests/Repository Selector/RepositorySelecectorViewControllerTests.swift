//
//  RepositorySelecectorViewControllerTests.swift
//  gazersUITests
//
//  Created by Nicolò Pasini on 16/03/21.
//

import XCTest

class RepositorySelecectorViewControllerTests: XCTestCase {

    var app: XCUIApplication!
    let testRepoName: String = "test-name"
    let testRepoOwner: String = "test-owner"

    override func setUp() {
        app = XCUIApplication()

        app.launchArguments = ["-UITesting", "true", "-testPage", "repositorySelector"]

        app.launch()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppearance() throws {
        XCTAssertFalse(app.navigationBars[""].exists)

        let contentView = app.otherElements["contentView"]
        XCTAssertTrue(contentView.exists)

        let titleLabel = app.staticTexts["titleLable"]
        XCTAssertTrue(titleLabel.exists)
        XCTAssertEqual(titleLabel.label, "Starred repository")

        let repoNameLabel = app.staticTexts["repoNameLable"]
        XCTAssertTrue(repoNameLabel.exists)
        XCTAssertEqual(repoNameLabel.label, "Repository name")

        let repoOwnerLabel = app.staticTexts["repoOwnerLabel"]
        XCTAssertTrue(repoOwnerLabel.exists)
        XCTAssertEqual(repoOwnerLabel.label, "Owner")

        let repoNameTextField = app.textFields["repoNameTextField"]
        XCTAssertTrue(repoNameTextField.exists)
        XCTAssertEqual(repoNameTextField.label, "")
        XCTAssertEqual(repoNameTextField.placeholderValue, "Insert repository name")

        let repoOwnerTextField = app.textFields["repoOwnerTextField"]
        XCTAssertTrue(repoOwnerTextField.exists)
        XCTAssertEqual(repoOwnerTextField.label, "")
        XCTAssertEqual(repoOwnerTextField.placeholderValue, "Insert repository owner")

        let confirmButton = app.buttons["confirmButton"]
        XCTAssertTrue(confirmButton.exists)
        XCTAssertEqual(confirmButton.label, "Confirm")
    }

    func testInsertRepoName() {
        let repoNameTextField = app.textFields["repoNameTextField"]
        repoNameTextField.tap()
        repoNameTextField.typeText(testRepoName)

        guard let text = repoNameTextField.value as? String else {
            XCTFail()
            return

        }
        XCTAssertEqual(text, testRepoName)
        XCTAssertEqual(repoNameTextField.placeholderValue, "Insert repository name")

        let confirmButton = app.buttons["confirmButton"]
        confirmButton.tap()

        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(errorAlert.exists)
        XCTAssertFalse(errorAlert.description.isEmpty)
    }

    func testInsertRepoOwner() {
        let repoNameOwnerField = app.textFields["repoOwnerTextField"]
        repoNameOwnerField.tap()
        repoNameOwnerField.typeText(testRepoOwner)

        guard let text = repoNameOwnerField.value as? String else {
            XCTFail()
            return

        }
        XCTAssertEqual(text, testRepoOwner)
        XCTAssertEqual(repoNameOwnerField.placeholderValue, "Insert repository owner")

        let confirmButton = app.buttons["confirmButton"]
        confirmButton.tap()

        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(errorAlert.exists)
        XCTAssertFalse(errorAlert.description.isEmpty)
    }

    func testInsertRepoNameAndOwner() {
        let repoNameTextField = app.textFields["repoNameTextField"]
        repoNameTextField.tap()
        repoNameTextField.typeText(testRepoName)

        let repoNameOwnerField = app.textFields["repoOwnerTextField"]
        repoNameOwnerField.tap()
        repoNameOwnerField.typeText(testRepoOwner)

        let confirmButton = app.buttons["confirmButton"]
        confirmButton.tap()

        XCTAssert(app.navigationBars["Star Gazers List"].exists)
    }
}
