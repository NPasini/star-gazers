//
//  TestStarGazersRepository.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 17/03/21.
//

@testable import gazers

import Quick
import Nimble
import ReactiveSwift

class TestStarGazersRepository: StarGazersRepositoryService {

    let owner: String
    let perPageItems: Int
    let repository: String

    init(repository: String, owner: String, perPageItems: Int) {
        self.owner = owner
        self.repository = repository
        self.perPageItems = perPageItems
    }

    func getGazers(page: Int) -> SignalProducer<[Gazer], NSError> {
        return SignalProducer<[Gazer], NSError> { [weak self] (observer, lifetime) in
            guard let weakSelf = self else { return }

            let minIndex = (page - 1)*weakSelf.perPageItems
            let maxIndex = min(page*weakSelf.perPageItems, TestGazers.allTestGazers.count)
            let pagedGazsers = TestGazers.allTestGazers[minIndex..<maxIndex]

            observer.send(value: Array(pagedGazsers))
            observer.sendCompleted()
        }
    }
}
