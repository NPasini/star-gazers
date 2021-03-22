//
//  RepositortAssembly.swift
//  gazers
//
//  Created by Nicolò Pasini on 17/03/21.
//

import Swinject

class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StarGazersRepositoryService.self) { _, repositoryName, repositoryOwner, perPageItems in return StarGazersRepository(repository: repositoryName, owner: repositoryOwner, perPageItems: perPageItems) }
    }
}

