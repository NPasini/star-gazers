//
//  BaseViewController.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import UIKit

class BaseViewController: UIViewController {
    private let viewModel: ViewModel

    required init?(coder: NSCoder) {
        fatalError("You must create the view controller passing a view model")
    }

    init?(coder: NSCoder, viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
}
