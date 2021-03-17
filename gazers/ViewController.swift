//
//  ViewController.swift
//  gazers
//
//  Created by Nicolò Pasini on 16/03/21.
//

import UIKit
import ReactiveSwift

class ViewController: UIViewController {

    private let serialDisposable: SerialDisposable = SerialDisposable(nil)
    private let gazers: MutableProperty<[Gazer]> = MutableProperty([])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

