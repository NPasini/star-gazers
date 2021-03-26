//
//  NotAvailableNetworkMonitor.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 26/03/21.
//

@testable import gazers

import ReactiveSwift

class NotAvailableNetworkMonitor: NetworkMonitorService {
    var isNetworkAvailable: Property<Bool?> = Property(value: false)
}
