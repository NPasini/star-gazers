//
//  TestGazers.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 20/03/21.
//

@testable import gazers

struct TestGazers {
    static let testGazer1 = Gazer(id: 1, name: "Test1", avatarUrl: nil)
    static let testGazer2 = Gazer(id: 2, name: "Test2", avatarUrl: nil)
    static let testGazer3 = Gazer(id: 3, name: "Test3", avatarUrl: nil)
    static let testGazer4 = Gazer(id: 4, name: "Test4", avatarUrl: nil)
    static let testGazer5 = Gazer(id: 5, name: "Test5", avatarUrl: nil)

    static let allTestGazers = [testGazer1, testGazer2, testGazer3, testGazer4, testGazer5]
}
