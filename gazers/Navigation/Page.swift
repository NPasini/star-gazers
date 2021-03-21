//
//  Page.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import Foundation

enum Page {
    case starGazerList

    var storyboardId: String {
        switch self {
        case .starGazerList:
            return "Main"
        }
    }

    var identifier: String {
        switch self {
        case .starGazerList:
            return StarGazersListViewController.identifier
        }
    }

    func getViewController(coder: NSCoder, viewModel: ViewModel?) -> BaseViewController? {
        switch self {
        case .starGazerList:
            let viewModel = StarGazersListViewModel()
            return StarGazersListViewController(coder: coder, viewModel: viewModel)
        }
    }
}
