//
//  Page.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import Foundation

enum Page {
    case starGazerList
    case repositorySelector

    var storyboardId: String {
        switch self {
        case .starGazerList, .repositorySelector:
            return "Main"
        }
    }

    var identifier: String {
        switch self {
        case .starGazerList:
            return StarGazersListViewController.identifier
        case .repositorySelector:
            return RepositorySelectorViewController.identifier
        }
    }

    func getViewController(coder: NSCoder, viewModel: ViewModel?) -> BaseViewController? {
        guard let vm = viewModel else { return nil }

        switch self {
        case .starGazerList:
            return StarGazersListViewController(coder: coder, viewModel: vm)
        case .repositorySelector:
            return RepositorySelectorViewController(coder: coder, viewModel: vm)
        }
    }
}
