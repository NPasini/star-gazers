//
//  StarGazersListViewModelTests.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import Quick
import Nimble
import ReactiveSwift

class StarGazersListViewModelTests: QuickSpec {

    let perpageItems: Int = 3
    let testOwner: String = "TestOwner"
    let testRepository: String = "TestRepository"
    let timeout: DispatchTimeInterval = .milliseconds(300)
    let pollingTimer: DispatchTimeInterval = .milliseconds(100)
    let secondPageGazers = [TestGazers.testGazer4, TestGazers.testGazer5]
    let firstPageGazers = [TestGazers.testGazer1, TestGazers.testGazer2, TestGazers.testGazer3]

    var viewModel: StarGazersListViewModel!

    override func spec() {
        context("Testing the StarGazersListViewModel") {
            beforeEach {
                AssemblerWrapper.shared.register(assemblies: [TestRepositoriesAssembly()])

                self.viewModel = StarGazersListViewModel(repositoryName: self.testRepository, repositoryOwner: self.testOwner, perPageItems: self.perpageItems)
            }

            describe("when is instantiated") {
                it("should contain the default values") {
                    expect(self.viewModel.isValid()).to(equal(true))
                    expect(self.viewModel.errorMessage()).to(equal(""))
                    expect(self.viewModel.gazersDataSource.value).to(equal([]))
                    expect(self.viewModel.stopFetchingData.value).to(equal(false))
                }
            }

            describe("when requesting the star gazers") {
                it("the datasource should be updated correctly") {
                    self.viewModel.getStarGazers()

                    expect(self.viewModel.isValid()).to(equal(true))
                    expect(self.viewModel.errorMessage()).to(equal(""))
                    expect(self.viewModel.gazersDataSource.value).toEventually(equal(self.firstPageGazers), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                    expect(self.viewModel.stopFetchingData.value).toEventually(equal(false), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                }

                it("should signal to stop loading when reached the end of the content") {
                    self.viewModel.getStarGazers()

                    // Wait first page data from repository are retrieved
                    expect(self.viewModel.gazersDataSource.value.count).toEventually(beGreaterThan(0), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)

                    self.viewModel.getStarGazers()

                    expect(self.viewModel.isValid()).to(equal(true))
                    expect(self.viewModel.errorMessage()).to(equal(""))
                    expect(self.viewModel.gazersDataSource.value).toEventually(equal(self.firstPageGazers + self.secondPageGazers), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                    expect(self.viewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                }
            }
        }
    }
}
