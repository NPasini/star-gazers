//
//  TestRepositortAssembly.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 17/03/21.
//

@testable import gazers

import Swinject

class TestRepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StarGazersRepositoryService.self) { (_, repositoryName: String, repositoryOwner: String, perPageItems: Int) in return TestStarGazersRepository(repository: repositoryName, owner: repositoryOwner, perPageItems: perPageItems) }
    }
}
