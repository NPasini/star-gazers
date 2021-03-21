//
//  RepositorySelectorViewModel.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import Foundation

struct RepositorySelectorViewModel {
    private(set) var repositoryName: String?
    private(set) var repositoryOwner: String?

    mutating func setRepositoryName(_ name: String?) {
        repositoryName = name
    }

    mutating func setRepositoryOwner(_ owner: String?) {
        repositoryOwner = owner
    }
}
