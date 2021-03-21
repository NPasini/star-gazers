//
//  StarGazersListViewController.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import UIKit
import OSLogger
import ReactiveCocoa
import ReactiveSwift

class StarGazersListViewController: BaseViewController {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!

    private var compositeDisposable = CompositeDisposable()
    private let gazersRepository: StarGazersRepositoryService? = AssemblerWrapper.shared.resolve(StarGazersRepositoryService.self)

    private var gazersViewModel: StarGazersListViewModel? {
        return viewModel as? StarGazersListViewModel
    }

    deinit {
        if (!compositeDisposable.isDisposed) {
            compositeDisposable.dispose()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        setTitle("Star Gazers List", color: UIColor.frontOrange)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self

        let spinnerView = UIActivityIndicatorView(style: .large)
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))

        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.startAnimating()
        footerView.addSubview(spinnerView)

        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])

        tableView.rowHeight = 180
        tableView.tableFooterView = footerView
//        tableView.register(viewType: BeerTableViewCell.self)
        tableView.backgroundColor = UIColor.clear

        if let vm = gazersViewModel {
            compositeDisposable += tableView.reactive.reloadData <~ vm.gazersDataSource.signal.map({ _ in
                OSLogger.uiLog(message: "Reloading TableView", access: .public, type: .debug)
                return })

            compositeDisposable += spinnerView.reactive.isAnimating <~ vm.stopFetchingData.producer.map({ [weak self] (stopFetching: Bool) -> Bool in
                DispatchQueue.main.async {
                    if (stopFetching) {
                        self?.tableView.tableFooterView = UIView(frame: .zero)
                    } else {
                        self?.tableView.tableFooterView = footerView
                    }
                }

                return !stopFetching
            })
        }
    }

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        customizeNavigationBar(backgroundColor: UIColor.backGrey, backButtonColor: UIColor.lightText)
    }
}

extension StarGazersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gazersViewModel?.gazersDataSource.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cellModel = gazersViewModel?.gazersDataSource.value[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell {
//            cell.delegate = self
//            cell.configure(with: cellModel)
//            return cell
//        } else {
            return UITableViewCell()
//        }
    }
}

extension StarGazersListViewController: UITableViewDelegate {
}

extension StarGazersListViewController: UITableViewDataSourcePrefetching {
    private func isLoadingCell(at indexPath: IndexPath) -> Bool {
        if let currentCount = gazersViewModel?.gazersDataSource.value.count {
            return indexPath.row >= (currentCount - 1)
        } else {
            return false
        }
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if (indexPaths.contains(where: isLoadingCell(at:))) {
            OSLogger.uiLog(message: "Fetching new Data Models", access: .public, type: .debug)
            gazersViewModel?.getStarGazers()
        }
    }
}
