//
//  MockedStarGazersRepository.swift
//  gazersUITests
//
//  Created by Nicolò Pasini on 25/03/21.
//

import Foundation
import ReactiveSwift

class MockedStarGazersRepository: StarGazersRepositoryService {

    let perPageItems: Int

    init(perPageItems: Int) {
        self.perPageItems = perPageItems
    }

    func getGazers(page: Int) -> SignalProducer<[Gazer], NSError> {
        return SignalProducer<[Gazer], NSError> { [weak self] (observer, lifetime) in
            guard let weakSelf = self else { return }

            let minIndex = (page - 1)*weakSelf.perPageItems
            let maxIndex = min(page*weakSelf.perPageItems, weakSelf.allTestGazers.count)
            let pagedGazsers = weakSelf.allTestGazers[minIndex..<maxIndex]

            observer.send(value: Array(pagedGazsers))
            observer.sendCompleted()
        }
    }

    // Mocked Data
    let testGazer1 = Gazer(id: 1, name: "Test1", avatarUrl: nil)
    let testGazer2 = Gazer(id: 2, name: "Test2", avatarUrl: nil)
    let testGazer3 = Gazer(id: 3, name: "Test3", avatarUrl: nil)
    let testGazer4 = Gazer(id: 4, name: "Test4", avatarUrl: nil)
    let testGazer5 = Gazer(id: 5, name: "Test5", avatarUrl: nil)
    let testGazer6 = Gazer(id: 6, name: "Test6", avatarUrl: nil)
    let testGazer7 = Gazer(id: 7, name: "Test7", avatarUrl: nil)
    let testGazer8 = Gazer(id: 8, name: "Test8", avatarUrl: nil)
    let testGazer9 = Gazer(id: 9, name: "Test9", avatarUrl: nil)
    let testGazer10 = Gazer(id: 10, name: "Test10", avatarUrl: nil)
    let testGazer11 = Gazer(id: 11, name: "Test11", avatarUrl: nil)
    let testGazer12 = Gazer(id: 12, name: "Test12", avatarUrl: nil)
    let testGazer13 = Gazer(id: 13, name: "Test13", avatarUrl: nil)
    let testGazer14 = Gazer(id: 14, name: "Test14", avatarUrl: nil)
    let testGazer15 = Gazer(id: 15, name: "Test15", avatarUrl: nil)
    let testGazer16 = Gazer(id: 16, name: "Test16", avatarUrl: nil)
    let testGazer17 = Gazer(id: 17, name: "Test17", avatarUrl: nil)
    let testGazer18 = Gazer(id: 18, name: "Test18", avatarUrl: nil)
    let testGazer19 = Gazer(id: 19, name: "Test19", avatarUrl: nil)
    let testGazer20 = Gazer(id: 20, name: "Test20", avatarUrl: nil)
    let testGazer21 = Gazer(id: 21, name: "Test21", avatarUrl: nil)
    let testGazer22 = Gazer(id: 22, name: "Test22", avatarUrl: nil)
    let testGazer23 = Gazer(id: 23, name: "Test23", avatarUrl: nil)
    let testGazer24 = Gazer(id: 24, name: "Test24", avatarUrl: nil)
    let testGazer25 = Gazer(id: 25, name: "Test25", avatarUrl: nil)
    let testGazer26 = Gazer(id: 26, name: "Test26", avatarUrl: nil)
    let testGazer27 = Gazer(id: 27, name: "Test27", avatarUrl: nil)
    let testGazer28 = Gazer(id: 28, name: "Test28", avatarUrl: nil)
    let testGazer29 = Gazer(id: 29, name: "Test29", avatarUrl: nil)
    let testGazer30 = Gazer(id: 30, name: "Test30", avatarUrl: nil)

    var allTestGazers: [Gazer] {
        return [testGazer1, testGazer2, testGazer3, testGazer4, testGazer5, testGazer6, testGazer7, testGazer8, testGazer9, testGazer10, testGazer11, testGazer12, testGazer13, testGazer14, testGazer15, testGazer16, testGazer17, testGazer18, testGazer19, testGazer20, testGazer21, testGazer22, testGazer23, testGazer24, testGazer25, testGazer26, testGazer27, testGazer28, testGazer29, testGazer30]
    }
}
