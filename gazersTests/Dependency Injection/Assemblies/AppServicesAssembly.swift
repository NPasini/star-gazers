//
//  AppServicesAssembly.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import Swinject

class AppServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NavigationService.self) { _ in return TestNavigation() }.inObjectScope(.container)
    }
}
