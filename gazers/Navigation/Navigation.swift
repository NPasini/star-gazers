//
//  Navigation.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import UIKit

enum Navigation {
    func navigate(to page: Page, with viewModel: ViewModel?) -> BaseViewController? {
        UIStoryboard().instantiateViewController(identifier: page.identifier) { (coder: NSCoder) -> BaseViewController? in
            switch page {
            case .starGazerList:
                let viewModel = StarGazersListViewModel()
                return StarGazersListViewController(coder: coder, viewModel: viewModel)
            }
        }
    }
}
