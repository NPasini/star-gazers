//
//  AvailableNetworkMonitor.swift
//  gazers
//
//  Created by Nicolò Pasini on 25/03/21.
//

import ReactiveSwift

class AvailableNetworkMonitor: NetworkMonitorService {
    var isNetworkAvailable: Property<Bool?> = Property(value: true)

    func stopMonitoring() {
    }
}
