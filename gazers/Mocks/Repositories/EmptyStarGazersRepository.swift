//
//  EmptyStarGazersRepository.swift
//  gazers
//
//  Created by Nicolò Pasini on 25/03/21.
//

import Foundation
import ReactiveSwift

class EmptyStarGazersRepository: StarGazersRepositoryService {

    let perPageItems: Int

    init(perPageItems: Int) {
        self.perPageItems = perPageItems
    }

    func getGazers(page: Int) -> SignalProducer<[Gazer], NSError> {
        return SignalProducer<[Gazer], NSError> { (observer, lifetime) in
            observer.send(value: Array())
            observer.sendCompleted()
        }
    }
}

