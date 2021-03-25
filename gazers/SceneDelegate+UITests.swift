//
//  SceneDelegate+UITests.swift
//  gazers
//
//  Created by Nicolò Pasini on 24/03/21.
//

import UIKit

extension SceneDelegate {
    func createViewControllerForTesting(using navigationService: NavigationService?, presenter: UINavigationController) {

        var page: Page?
        var viewModel: ViewModel?
        let environment = ProcessInfo.processInfo.environment

        guard let testPage = environment["testPage"] else { return }

        switch testPage {
        case "starGazerList":
            page = .starGazerList
//            viewModel = JSONDecoder().decode(StarGazersListViewModelProtocol.self, from: mockedViewModelData!)
        case "repositorySelector":
            page = .repositorySelector
            viewModel = RepositorySelectorViewModel()
        default: ()
        }

        if let selectedPage = page, let navigation = navigationService {
            navigation.push(page: selectedPage, with: viewModel, using: presenter, animated: false)
        }
    }
}
