//
//  AvailableNetowrkAssembly.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import Swinject

class AvailableNetowrkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return AvailableNetworkMonitor() }
    }
}
