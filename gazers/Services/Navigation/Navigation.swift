//
//  Navigation.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import UIKit

struct Navigation {
    static func push(page: Page, with viewModel: ViewModel?, using navigationController: UINavigationController?, animated: Bool = true) {
        guard let navController = navigationController else { return }
        
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: page.identifier) { (coder: NSCoder) -> BaseViewController? in
            page.getViewController(coder: coder, viewModel: viewModel)
        }

        navController.pushViewController(viewController, animated: animated)
    }
}
