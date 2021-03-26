//
//  MockedServicesWithNotAvailableNetworkAssembly.swift
//  gazers
//
//  Created by Nicolò Pasini on 25/03/21.
//

import Swinject

class MockedServicesWithNotAvailableNetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return NotAvailableNetworkMonitor() }
        container.register(NavigationService.self) { _ in return Navigation() }.inObjectScope(.container)
        container.register(StarGazersRepositoryService.self) { (_, _: String, _: String, perPageItems: Int) in return EmptyStarGazersRepository(perPageItems: perPageItems) }
    }
}
