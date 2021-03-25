//
//  StarGazersListViewModelProtocol.swift
//  gazers
//
//  Created by Nicolò Pasini on 25/03/21.
//

import ReactiveSwift

protocol StarGazersListViewModelProtocol: ViewModel {
    var stopFetchingData: Property<Bool> { get }
    var gazersDataSource: MutableProperty<[Gazer]> { get }

    func getStarGazers()
}
