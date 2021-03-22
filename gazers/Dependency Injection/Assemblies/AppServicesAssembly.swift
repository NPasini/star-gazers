//
//  AppServicesAssembly.swift
//  gazers
//
//  Created by Nicolò Pasini on 22/03/21.
//

import Swinject

class AppServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return NetworkMonitor() }.inObjectScope(.container)
    }
}
