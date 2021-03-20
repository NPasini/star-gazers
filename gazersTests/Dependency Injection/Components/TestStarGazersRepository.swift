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
    let repository: String

    init(repository: String, owner: String) {
        self.owner = owner
        self.repository = repository
    }

    func getGazers(page: Int) -> SignalProducer<[Gazer], NSError> {
        return SignalProducer<[Gazer], NSError> { (observer, lifetime) in
            observer.send(value: TestGazers.allTestGazers)
            observer.sendCompleted()
        }
    }
}
