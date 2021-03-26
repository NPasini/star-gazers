//
//  RepositorySelectorViewControllerTests.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import UIKit
import Quick
import Nimble

class RepositorySelectorViewControllerTests: QuickSpec {

    let testOwner: String = "TestOwner"
    let testRepository: String = "TestRepository"

    var presenter: UINavigationController!
    var navigationService: NavigationService?
    var viewController: RepositorySelectorViewController!

    override func spec() {
        context("Testing the RepositorySelectorViewController") {
            beforeEach {
                AssemblerWrapper.shared.register(assemblies: [AppServicesWithAvailableNetworkAssembly()])

                self.presenter = UINavigationController()
                self.navigationService = AssemblerWrapper.shared.resolve(NavigationService.self)

                let viewModel = RepositorySelectorViewModel()
                self.navigationService?.push(page: .repositorySelector, with: viewModel, using: self.presenter)
                self.viewController = self.presenter.viewControllers.first as? RepositorySelectorViewController
            }

            describe("when is instantiated") {
                it("the UI should contain the default values") {
                    expect(self.presenter.navigationBar.isHidden).to(equal(true))

                    expect(self.viewController.repoNameText.text).toNot(beNil())
                    expect(self.viewController.repoOwnerText.text).toNot(beNil())
                    expect(self.viewController.repoNameText.delegate).to(be(self.viewController))
                    expect(self.viewController.repoOwnerText.delegate).to(be(self.viewController))

                    expect(self.viewController.repositoryViewModel.isValid()).to(equal(false))
                    expect(self.viewController.repositoryViewModel.errorMessage()).toNot(beNil())
                    expect(self.viewController.repositoryViewModel.repositoryName).to(equal(""))
                    expect(self.viewController.repositoryViewModel.repositoryOwner).to(equal(""))
                }
            }

            describe("when the text is set only in the repo owner TextFields") {
                it("the view model should be updated accordingly and be not valid") {
                    self.viewController.repoOwnerText.text = self.testOwner
                    expect(self.viewController.repoNameText.text).to(equal(""))
                    expect(self.viewController.repoOwnerText.text).to(equal(self.testOwner))

                    self.viewController.textFieldDidEndEditing(self.viewController.repoOwnerText)

                    expect(self.viewController.repositoryViewModel.isValid()).to(equal(false))
                    expect(self.viewController.repositoryViewModel.repositoryName).to(equal(""))
                    expect(self.viewController.repositoryViewModel.repositoryOwner).to(equal(self.testOwner))
                }
            }

            describe("when the text is set only in the repo name TextFields") {
                it("the view model should be updated accordingly and be not valid") {
                    self.viewController.repoNameText.text = self.testRepository
                    expect(self.viewController.repoOwnerText.text).to(equal(""))
                    expect(self.viewController.repoNameText.text).to(equal(self.testRepository))

                    self.viewController.textFieldDidEndEditing(self.viewController.repoNameText)

                    expect(self.viewController.repositoryViewModel.isValid()).to(equal(false))
                    expect(self.viewController.repositoryViewModel.repositoryOwner).to(equal(""))
                    expect(self.viewController.repositoryViewModel.repositoryName).to(equal(self.testRepository))
                }
            }

            describe("when the text is set in the TextFields") {
                it("the view model should be updated accordingly and be valid") {
                    self.viewController.repoOwnerText.text = self.testOwner
                    self.viewController.repoNameText.text = self.testRepository
                    self.viewController.textFieldDidEndEditing(self.viewController.repoNameText)
                    self.viewController.textFieldDidEndEditing(self.viewController.repoOwnerText)

                    expect(self.viewController.repositoryViewModel.isValid()).to(equal(true))
                    expect(self.viewController.repoOwnerText.text).to(equal(self.testOwner))
                    expect(self.viewController.repoNameText.text).to(equal(self.testRepository))
                }
            }

            afterEach {
                self.presenter.viewControllers = []
            }
        }
    }
}

