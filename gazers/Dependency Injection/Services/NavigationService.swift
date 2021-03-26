//
//  NavigationService.swift
//  gazers
//
//  Created by Nicolò Pasini on 23/03/21.
//

import UIKit

protocol NavigationService {
    func push(page: Page, with viewModel: ViewModel?, using navigationController: UINavigationController?, animated: Bool)
}

extension NavigationService {
    func push(page: Page, with viewModel: ViewModel?, using navigationController: UINavigationController?, animated: Bool = true) {
        push(page: page, with: viewModel, using: navigationController, animated: true)
    }
}
