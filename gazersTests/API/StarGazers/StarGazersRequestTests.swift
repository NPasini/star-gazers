//
//  StarGazersRequestTests.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 17/03/21.
//

@testable import gazers

import Quick
import Nimble
import Foundation

class StarGazersRequestTests: QuickSpec {
    private let page: Int = 1
    private let repositoryName: String = "testName"
    private let repositoryOwner: String = "testOwner"

    override func spec() {
        context("Testing the Star Gazers API request"){
            describe("when is created specifying the page an istance of the request"){
                it("should contain correct endpoint and parameters"){
                    let request = StarGazersRequest(repositoryName: self.repositoryName, owner: self.repositoryOwner, page: self.page)

                    expect(request.host).to(equal("api.github.com"))
                    expect(request.version).to(beNil())
                    expect(request.path).to(equal("repos/\(self.repositoryOwner)/\(self.repositoryName)/stargazers"))
                    expect(request.queryParameters).notTo(beNil())

                    if let pageParameter = request.queryParameters?[request.pageKey] as? Int {
                        expect(pageParameter).to(equal(self.page))
                    } else {
                        fail("Page parameter not present")
                    }

                    if let perPageParameter = request.queryParameters?[request.perPageKey] as? Int {
                        expect(perPageParameter).to(equal(request.perPageItems))
                    } else {
                        fail("Per page parameter not present")
                    }
                }
            }
        }
    }
}

