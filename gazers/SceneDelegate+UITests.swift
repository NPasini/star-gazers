//
//  SceneDelegate+UITests.swift
//  gazers
//
//  Created by Nicolò Pasini on 24/03/21.
//

import UIKit

extension SceneDelegate {
    func createViewControllerForTesting(test: String, using navigationService: NavigationService?, presenter: UINavigationController) {
        let environment = ProcessInfo.processInfo.environment
//        guard let screenToLaunch = environment["screenToLaunch"] else { return }

        var page: Page?
        var viewModel: ViewModel?

        switch test {
        case "starGazerList":
            page = .starGazerList
        case "repositorySelector":
            page = .repositorySelector
        default: ()
        }

        if let selectedPage = page, let navigation = navigationService {
            navigation.push(page: selectedPage, with: viewModel, using: presenter, animated: false)
        }
    }
}
