//
//  StarGazersResponseTests.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 17/03/21.
//

@testable import gazers

import Quick
import Nimble
import Foundation

class StarGazersResponseTests: QuickSpec {
    override func spec() {
        context("Testing the Star Gazers API response") {
            describe("should not be decoded"){
                it("with empty data"){
                    let response = StarGazersResponse.decode(Data())
                    expect(response).to(beNil())
                }

                it("with a json where some of the Gazers have not the id"){
                    let jsonData = Json(fileName: "starGazersNoIds").convertToData()

                    let response = StarGazersResponse.decode(jsonData)
                    expect(response).to(beNil())
                }
            }

            describe("the response should be decoded") {
                it("with correct json to parse"){
                    let jsonData = Json(fileName: "starGazersResponse").convertToData()

                    let response = StarGazersResponse.decode(jsonData)
                    expect(response).notTo(beNil())
                    expect(response).to(beAnInstanceOf(StarGazersResponse.self))

                    let gazersResponse = response as! StarGazersResponse
                    expect(gazersResponse.gazers.count).to(equal(3))

                    gazersResponse.gazers.forEach { (gazer: Gazer) in
                        expect(gazer.id).notTo(beNil())
                        expect(gazer.name).notTo(beNil())
                        expect(gazer.avatarUrl).notTo(beNil())
                    }
                }

                it("with a json where some of the Gazers have not the name"){
                    let jsonData = Json(fileName: "starGazersNoAvatarResponse").convertToData()

                    let response = StarGazersResponse.decode(jsonData)
                    expect(response).notTo(beNil())
                    expect(response).to(beAnInstanceOf(StarGazersResponse.self))

                    let gazersResponse = response as! StarGazersResponse
                    expect(gazersResponse.gazers.count).to(equal(3))

                    gazersResponse.gazers.forEach { (gazer: Gazer) in
                        expect(gazer.id).notTo(beNil())
                    }
                }
            }
        }
    }
}


