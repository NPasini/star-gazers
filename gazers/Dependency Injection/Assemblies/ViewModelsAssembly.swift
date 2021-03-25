//
//  ViewModelsAssembly.swift
//  gazers
//
//  Created by Nicolò Pasini on 25/03/21.
//

import Swinject

class ViewModelsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RepositorySelectorViewModelProtocol.self) { _ in return RepositorySelectorViewModel() }
        container.register(StarGazersListViewModelProtocol.self) { _, repositoryName, repositoryOwner, perPageItems in return StarGazersListViewModel(repositoryName: repositoryName, repositoryOwner: repositoryOwner, perPageItems: perPageItems) }
        container.register(StarGazersListViewModelProtocol.self) { _, repositoryName, repositoryOwner in return StarGazersListViewModel(repositoryName: repositoryName, repositoryOwner: repositoryOwner) }
    }
}
