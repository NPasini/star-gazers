//
//  RepositorySelectorViewModel.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import Foundation

struct RepositorySelectorViewModel: ViewModel {

    private(set) var repositoryName: String?
    private(set) var repositoryOwner: String?

    mutating func setRepositoryName(_ name: String?) {
        repositoryName = name
    }

    mutating func setRepositoryOwner(_ owner: String?) {
        repositoryOwner = owner
    }

    func isValid() -> Bool {
        guard let name = repositoryName, let owner = repositoryOwner else { return false }
        return !name.isEmpty && !owner.isEmpty
    }

    func errorMessage() -> String {
        return "Please, insert both the repository name and the repository owner"
    }
}
