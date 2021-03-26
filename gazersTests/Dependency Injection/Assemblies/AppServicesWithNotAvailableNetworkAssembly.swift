//
//  AppServicesWithNotAvailableNetworkAssembly.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 26/03/21.
//

@testable import gazers

import Swinject

class AppServicesWithNotAvailableNetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return NotAvailableNetworkMonitor() }
        container.register(NavigationService.self) { _ in return TestNavigation() }.inObjectScope(.container)
        container.register(StarGazersRepositoryService.self) { (_, repositoryName: String, repositoryOwner: String, perPageItems: Int) in return EmptyTestStarGazersRepository(repository: repositoryName, owner: repositoryOwner, perPageItems: perPageItems) }
    }
}
