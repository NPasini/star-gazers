//
//  RepositorySelectorViewModelProtocol.swift
//  gazers
//
//  Created by Nicolò Pasini on 25/03/21.
//

import Foundation

protocol RepositorySelectorViewModelProtocol: ViewModel {
    var repositoryName: String { get }
    var repositoryOwner: String { get }
}
