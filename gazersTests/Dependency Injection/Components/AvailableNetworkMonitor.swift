//
//  AvailableNetworkMonitor.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import ReactiveSwift

class AvailableNetworkMonitor: NetworkMonitorService {
    var isNetworkAvailable: Property<Bool?> = Property(value: true)

    func stopMonitoring() {
    }
}
