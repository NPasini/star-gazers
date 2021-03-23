//
//  RepositorySelectorViewModelTests.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import Quick
import Nimble

class RepositorySelectorViewModelTests: QuickSpec {

    let testOwner: String = "TestOwner"
    let testRepository: String = "TestRepository"

    var viewModel: RepositorySelectorViewModel!

    override func spec() {
        context("Testing the RepositorySelectorViewModel") {
            beforeEach {
                self.viewModel = RepositorySelectorViewModel()
            }

            describe("when is instantiated") {
                it("should contain the default values") {
                    expect(self.viewModel.isValid()).to(equal(false))
                    expect(self.viewModel.errorMessage()).toNot(beNil())
                    expect(self.viewModel.repositoryName).to(equal(""))
                    expect(self.viewModel.repositoryOwner).to(equal(""))
                }
            }

            describe("the view model should not be valid") {
                it("when is set only the repo name") {
                    self.viewModel.setRepositoryName(self.testRepository)
                    
                    expect(self.viewModel.isValid()).to(equal(false))
                    expect(self.viewModel.repositoryOwner).to(equal(""))
                    expect(self.viewModel.repositoryName).to(equal(self.testRepository))
                }
            }

            describe("the view model should not be valid") {
                it("when is set only the repo owner") {
                    self.viewModel.setRepositoryOwner(self.testOwner)

                    expect(self.viewModel.isValid()).to(equal(false))
                    expect(self.viewModel.repositoryName).to(equal(""))
                    expect(self.viewModel.repositoryOwner).to(equal(self.testOwner))
                }
            }

            describe("the view model should be valid") {
                it("when is set the repo owner and teh repo name") {
                    self.viewModel.setRepositoryOwner(self.testOwner)
                    self.viewModel.setRepositoryName(self.testRepository)

                    expect(self.viewModel.isValid()).to(equal(true))
                    expect(self.viewModel.repositoryOwner).to(equal(self.testOwner))
                    expect(self.viewModel.repositoryName).to(equal(self.testRepository))
                }
            }
        }
    }
}


