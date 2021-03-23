//
//  TestNavigation.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 23/03/21.
//

@testable import gazers

import UIKit

class TestNavigation: NavigationService {
    func push(page: Page, with viewModel: ViewModel?, using navigationController: UINavigationController?, animated: Bool = true) {
        guard let navController = navigationController else { return }

        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: page.identifier) { (coder: NSCoder) -> BaseViewController? in
            page.getViewController(coder: coder, viewModel: viewModel)
        }

        viewController.loadView()
        viewController.viewDidLoad()
        navController.pushViewController(viewController, animated: animated)
        viewController.viewWillAppear(false)
    }
}

