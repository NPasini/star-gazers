//
//  EmptyTestStarGazersRepository.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 26/03/21.
//

@testable import gazers

import Quick
import Nimble
import ReactiveSwift

class EmptyTestStarGazersRepository: StarGazersRepositoryService {

    let owner: String
    let perPageItems: Int
    let repository: String

    init(repository: String, owner: String, perPageItems: Int) {
        self.owner = owner
        self.repository = repository
        self.perPageItems = perPageItems
    }

    func getGazers(page: Int) -> SignalProducer<[Gazer], NSError> {
        return SignalProducer<[Gazer], NSError> { (observer, lifetime) in
            observer.send(value: Array())
            observer.sendCompleted()
        }
    }
}
