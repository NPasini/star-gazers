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

class StarGazersRepository {
    let owner: String
    let repository: String

    init(repository: String, owner: String) {
        self.owner = owner
        self.repository = repository
    }

    func getGazers(page: Int = 1) -> SignalProducer<Result<[Gazer], NSError>, Never> {
        let request = StarGazersRequest(repositoryName: repository, owner: owner, page: page)
        return observableForGetGazers(request)
    }

    private func observableForGetGazers(_ request: StarGazersRequest) -> SignalProducer<Result<[Gazer], NSError>, Never> {
        return SignalProducer {
            (observer, lifetime) in

            let subscription = APIPerformer.shared.performApi(request, QoS: .default, completionQueue: .global(qos: .userInteractive)) { (result: Result<StarGazersResponse, NSError>) in

                switch result {
                case .success(let response):
                    observer.send(value: Result.success(response.gazers))
                case .failure(let error):
                    observer.send(value: Result.failure(error))
                }

                observer.sendCompleted()
            }

            lifetime.observeEnded {
                subscription.dispose()
            }
        }
    }
}

