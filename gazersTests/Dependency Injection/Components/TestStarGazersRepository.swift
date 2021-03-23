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
    private var currentPage: Int

    init(repository: String, owner: String, perPageItems: Int) {
        self.owner = owner
        self.currentPage = 1
        self.repository = repository
        self.perPageItems = perPageItems
    }

    func getGazers(page: Int) -> SignalProducer<[Gazer], NSError> {
        return SignalProducer<[Gazer], NSError> { [weak self] (observer, lifetime) in
            guard let weakSelf = self else { return }

            let minIndex = (weakSelf.currentPage - 1)*weakSelf.perPageItems
            let maxIndex = min(weakSelf.currentPage*weakSelf.perPageItems, TestGazers.allTestGazers.count)
            let pagedGazsers = TestGazers.allTestGazers[minIndex..<maxIndex]

            weakSelf.currentPage += 1

            observer.send(value: Array(pagedGazsers))
            observer.sendCompleted()
        }
    }
}
