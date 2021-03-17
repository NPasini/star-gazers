//
//  StarGazersRepositoryService.swift
//  gazers
//
//  Created by Nicolò Pasini on 17/03/21.
//

import Foundation
import ReactiveSwift

protocol StarGazersRepositoryService {
    func getGazers(page: Int) -> SignalProducer<Result<[Gazer], NSError>, Never>
}

extension StarGazersRepositoryService {
    func getGazers(page: Int = 1) -> SignalProducer<Result<[Gazer], NSError>, Never> {
        getGazers(page: 1)
    }
}
