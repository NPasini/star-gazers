//
//  NotAvailableNetworkMonitor.swift
//  gazers
//
//  Created by Nicolò Pasini on 25/03/21.
//

import ReactiveSwift

class NotAvailableNetworkMonitor: NetworkMonitorService {
    var isNetworkAvailable: Property<Bool?> = Property(value: false)
}
