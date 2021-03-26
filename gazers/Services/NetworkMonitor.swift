//
//  NetworkMonitor.swift
//  gazers
//
//  Created by Nicolò Pasini on 22/03/21.
//

import Network
import OSLogger
import Foundation
import ReactiveSwift

class NetworkMonitor: NetworkMonitorService {
    let isNetworkAvailable: Property<Bool?>

    private let networkMonitor: NWPathMonitor
    private let networkAvailablePipe: (output: BoolSignal, input: BoolSignal.Observer)

    init() {
        networkMonitor = NWPathMonitor()
        networkAvailablePipe = BoolSignal.pipe()
        isNetworkAvailable = Property(initial: nil, then: networkAvailablePipe.output)

        startNetworkMonitor()
    }

    deinit {
        networkMonitor.cancel()
    }

    private func startNetworkMonitor() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                OSLogger.dataFlowLog(message: "Network available")
                self?.networkAvailablePipe.input.send(value: true)
            } else {
                OSLogger.dataFlowLog(message: "Network not available")
                self?.networkAvailablePipe.input.send(value: false)
            }
        }

        let networkMonitorQueue = DispatchQueue(label: "network_monitor_queue", qos: .background)
        networkMonitor.start(queue: networkMonitorQueue)
    }
}
