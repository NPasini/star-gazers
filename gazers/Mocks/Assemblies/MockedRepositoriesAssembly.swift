//
//  MockedRepositoriesAssembly.swift
//  gazersUITests
//
//  Created by Nicolò Pasini on 25/03/21.
//

import Swinject

class MockedRepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StarGazersRepositoryService.self) { (_, _: String, _: String, perPageItems: Int) in return MockedStarGazersRepository(perPageItems: perPageItems) }
    }
}
