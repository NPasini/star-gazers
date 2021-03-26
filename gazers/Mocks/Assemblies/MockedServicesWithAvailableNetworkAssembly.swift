//
//  MockedServicesWithAvailableNetworkAssembly.swift
//  gazers
//
//  Created by Nicolò Pasini on 25/03/21.
//

import Swinject

class MockedServicesWithAvailableNetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return AvailableNetworkMonitor() }
        container.register(NavigationService.self) { _ in return Navigation() }.inObjectScope(.container)
        container.register(StarGazersRepositoryService.self) { (_, _: String, _: String, perPageItems: Int) in return MockedStarGazersRepository(perPageItems: perPageItems) }
    }
}
