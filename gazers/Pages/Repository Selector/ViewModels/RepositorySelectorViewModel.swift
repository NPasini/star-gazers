//
//  RepositorySelectorViewModel.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import Foundation

class RepositorySelectorViewModel: RepositorySelectorViewModelProtocol {

    private(set) var repositoryName: String
    private(set) var repositoryOwner: String

    init() {
        repositoryName = ""
        repositoryOwner = ""
    }

    func setRepositoryName(_ name: String) {
        repositoryName = name
    }

    func setRepositoryOwner(_ owner: String) {
        repositoryOwner = owner
    }

    func isValid() -> Bool {
        return !repositoryName.isEmpty && !repositoryOwner.isEmpty
    }

    func errorMessage() -> String {
        return "Please, insert both the repository name and the repository owner"
    }
}
