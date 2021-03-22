//
//  NetworkMonitorService.swift
//  gazers
//
//  Created by Nicolò Pasini on 22/03/21.
//

import ReactiveSwift

protocol NetworkMonitorService {
    var isNetworkAvailable: Property<Bool?> { get }

    func stopMonitoring()
}
