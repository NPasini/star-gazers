//
//  StarGazersRepositoryService.swift
//  gazers
//
//  Created by Nicolò Pasini on 17/03/21.
//

import Foundation
import ReactiveSwift

protocol StarGazersRepositoryService {
    func getGazers(page: Int) -> SignalProducer<[Gazer], NSError>
}

extension StarGazersRepositoryService {
    func getGazers(page: Int = 1) -> SignalProducer<[Gazer], NSError> {
        getGazers(page: 1)
    }
}
