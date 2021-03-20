//
//  TestRepositortAssembly.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 17/03/21.
//

@testable import gazers

import Swinject
import Foundation

class TestRepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StarGazersRepositoryService.self) { _, repositoryName, repositoryOwner in return TestStarGazersRepository(repository: repositoryName, owner: repositoryOwner) }
    }
}
