//
//  StarGazersRepository.swift
//  gazers
//
//  Created by Nicolò Pasini on 16/03/21.
//

import OSLogger
import Foundation
import ReactiveSwift
import NetworkManager

class StarGazersRepository: StarGazersRepositoryService {
    let owner: String
    let perPageItems: Int
    let repository: String

    init(repository: String, owner: String, perPageItems: Int) {
        self.owner = owner
        self.repository = repository
        self.perPageItems = perPageItems
    }

    func getGazers(page: Int) -> SignalProducer<[Gazer], NSError> {
        let request = StarGazersRequest(repositoryName: repository, owner: owner, page: page, perPageItems: perPageItems)
        return observableForGetGazers(request)
    }

    private func observableForGetGazers(_ request: StarGazersRequest) -> SignalProducer<[Gazer], NSError> {
        return SignalProducer {
            (observer, lifetime) in

            let subscription = APIPerformer.shared.performApi(request, QoS: .default, completionQueue: .global(qos: .userInteractive)) { (result: Result<StarGazersResponse, NSError>) in

                switch result {
                case .success(let response):
                    observer.send(value: response.gazers)
                case .failure(let error):
                    observer.send(error: error)
                }

                observer.sendCompleted()
            }

            lifetime.observeEnded {
                subscription.dispose()
            }
        }
    }
}
