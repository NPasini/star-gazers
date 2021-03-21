//
//  StarGazersListViewController.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import UIKit

class StarGazersListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        setTitle("Star Gazers List", color: UIColor.frontOrange)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        customizeNavigationBar(backgroundColor: UIColor.backGrey, backButtonColor: UIColor.lightText)
    }
}
