//
//  AppServicesWithAvailableNetworkAssembly.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import Swinject

class AppServicesWithAvailableNetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return AvailableNetworkMonitor() }
        container.register(NavigationService.self) { _ in return TestNavigation() }.inObjectScope(.container)
        container.register(StarGazersRepositoryService.self) { (_, repositoryName: String, repositoryOwner: String, perPageItems: Int) in return TestStarGazersRepository(repository: repositoryName, owner: repositoryOwner, perPageItems: perPageItems) }
    }
}
