//
//  StarGazersListViewControllerTests.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import UIKit
import Quick
import Nimble

class StarGazersListViewControllerTests: QuickSpec {

    let perpageItems: Int = 3
    let testOwner: String = "TestOwner"
    let testRepository: String = "TestRepository"
    let timeout: DispatchTimeInterval = .milliseconds(300)
    let pollingTimer: DispatchTimeInterval = .milliseconds(100)
    let secondPageGazers = [TestGazers.testGazer4, TestGazers.testGazer5]
    let firstPageGazers = [TestGazers.testGazer1, TestGazers.testGazer2, TestGazers.testGazer3]

    var presenter: UINavigationController!
    var navigationService: NavigationService?
    var viewController: StarGazersListViewController!

    override func spec() {
        context("Testing the StarGazersListViewController with network avaialble") {
            beforeEach {
                AssemblerWrapper.shared.register(assemblies: [AppServicesWithAvailableNetworkAssembly()])

                self.presenter = UINavigationController()
                self.navigationService = AssemblerWrapper.shared.resolve(NavigationService.self)

                let viewModel = StarGazersListViewModel(repositoryName: self.testRepository, repositoryOwner: self.testOwner, perPageItems: self.perpageItems)
                self.navigationService?.push(page: .starGazerList, with: viewModel, using: self.presenter)
                self.viewController = self.presenter.viewControllers.first as? StarGazersListViewController
            }

            describe("when is instantiated") {
                it("the UI should contain the default values") {
                    expect(self.presenter.navigationBar.isHidden).to(equal(false))

                    expect(self.viewController.navigationItem.titleView).to(beAnInstanceOf(UILabel.self))
                    let titleView = self.viewController.navigationItem.titleView as! UILabel
                    expect(titleView.text).to(equal("Star Gazers List"))

                    expect(self.viewController.tableView.tableFooterView).toNot(beNil())
                    expect(self.viewController.tableView.delegate).to(be(self.viewController))
                    expect(self.viewController.tableView.dataSource).to(be(self.viewController))
                    expect(self.viewController.tableView.prefetchDataSource).to(be(self.viewController))

                    expect(self.viewController.gazersViewModel.isValid()).to(equal(true))
                    expect(self.viewController.gazersViewModel.errorMessage()).to(equal(""))
                    expect(self.viewController.gazersViewModel.stopFetchingData.value).toEventually(equal(false), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.gazersViewModel.gazersDataSource.value).toEventually(equal(self.firstPageGazers), timeout: self.timeout, pollInterval: self.pollingTimer)

                    expect(self.viewController.messageViewHeightConstraint.constant).to(equal(0))
                }
            }

            describe("when prefetching new data") {
                it("the new data should not be downoloaded when reaching a cell different from the last one") {
                    for index in 0..<self.firstPageGazers.count-1 {
                        self.viewController.tableView(self.viewController.tableView, prefetchRowsAt: [IndexPath(row: index, section: 0)])
                    }

                    expect(self.viewController.gazersViewModel.isValid()).to(equal(true))
                    expect(self.viewController.gazersViewModel.errorMessage()).to(equal(""))
                    expect(self.viewController.gazersViewModel.stopFetchingData.value).toEventuallyNot(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.gazersViewModel.gazersDataSource.value).toEventually(equal(self.firstPageGazers), timeout: self.timeout, pollInterval: self.pollingTimer)
                }

                it("the new data should be downoloaded when reaching the last item") {
                    self.viewController.tableView(self.viewController.tableView, prefetchRowsAt: [IndexPath(row: self.firstPageGazers.count - 1, section: 0)])

                    expect(self.viewController.gazersViewModel.isValid()).to(equal(true))
                    expect(self.viewController.gazersViewModel.errorMessage()).to(equal(""))
                    expect(self.viewController.gazersViewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.gazersViewModel.gazersDataSource.value).toEventually(equal(self.firstPageGazers + self.secondPageGazers), timeout: self.timeout, pollInterval: self.pollingTimer)
                }
            }

            afterEach {
                self.viewController = nil
                self.presenter.viewControllers = []

                // Check observables have been disposed and view controller has been deinited
                expect(self.viewController).to(beNil())
            }
        }

        context("Testing the StarGazersListViewController with network not avaialble") {
            beforeEach {
                AssemblerWrapper.shared.register(assemblies: [AppServicesWithNotAvailableNetworkAssembly()])

                self.presenter = UINavigationController()
                self.navigationService = AssemblerWrapper.shared.resolve(NavigationService.self)

                let viewModel = StarGazersListViewModel(repositoryName: self.testRepository, repositoryOwner: self.testOwner, perPageItems: self.perpageItems)
                self.navigationService?.push(page: .starGazerList, with: viewModel, using: self.presenter)
                self.viewController = self.presenter.viewControllers.first as? StarGazersListViewController
            }

            describe("when is instantiated") {
                it("the UI should contain the default values") {
                    expect(self.presenter.navigationBar.isHidden).to(equal(false))

                    expect(self.viewController.navigationItem.titleView).to(beAnInstanceOf(UILabel.self))
                    let titleView = self.viewController.navigationItem.titleView as! UILabel
                    expect(titleView.text).to(equal("Star Gazers List"))

                    expect(self.viewController.tableView.tableFooterView).toNot(beNil())
                    expect(self.viewController.tableView.delegate).to(be(self.viewController))
                    expect(self.viewController.tableView.dataSource).to(be(self.viewController))
                    expect(self.viewController.tableView.prefetchDataSource).to(be(self.viewController))

                    expect(self.viewController.gazersViewModel.isValid()).to(equal(true))
                    expect(self.viewController.gazersViewModel.errorMessage()).to(equal(""))
                    expect(self.viewController.gazersViewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.gazersViewModel.gazersDataSource.value).toEventually(equal([]), timeout: self.timeout, pollInterval: self.pollingTimer)

                    expect(self.viewController.messageViewHeightConstraint.constant).to(beGreaterThan(0))
                    expect(self.viewController.messageLabel.text).to(equal("Network not available"))
                }
            }

            describe("when the view controller is showed") {
                it("the data should not be downoloaded") {
                    expect(self.viewController.gazersViewModel.isValid()).to(equal(true))
                    expect(self.viewController.gazersViewModel.errorMessage()).to(equal(""))
                    expect(self.viewController.gazersViewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.gazersViewModel.gazersDataSource.value).toEventually(equal([]), timeout: self.timeout, pollInterval: self.pollingTimer)
                }
            }

            afterEach {
                self.viewController = nil
                self.presenter.viewControllers = []

                // Check observables have been disposed and view controller has been deinited
                expect(self.viewController).to(beNil())
            }
        }
    }
}


