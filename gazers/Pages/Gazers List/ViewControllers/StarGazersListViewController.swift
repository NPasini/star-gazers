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

    private let messageViewHeight: CGFloat = 40
    private let animationDuration: TimeInterval = 0.3
    private var isNetworkConnectionAvailable: Bool = true
    private var compositeDisposable = CompositeDisposable()
    private var networkMonitorService: NetworkMonitorService? = AssemblerWrapper.shared.resolve(NetworkMonitorService.self)

    var gazersViewModel: StarGazersListViewModelProtocol {
        if viewModel is StarGazersListViewModelProtocol {
            return viewModel as! StarGazersListViewModelProtocol
        } else {
            fatalError("The View Model has the wrong type")
        }
    }

    // MARK: - Lyfe Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureNavigationBar()
        setTitle("Star Gazers List", color: UIColor.frontOrange)
        messageViewHeightConstraint.constant = 0

        compositeDisposable += networkMonitorService?.isNetworkAvailable.signal.observeValues({ [weak self] (isAvailable: Bool?) in
            if let connectionAvailable = isAvailable {
                self?.isNetworkConnectionAvailable = connectionAvailable
                self?.shouldShowNetworkUnavailableMessage(!connectionAvailable)
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        gazersViewModel.getStarGazers()
    }

    deinit {
        OSLogger.uiLog(message: "Deiniting \(String(describing: StarGazersListViewController.self)) and disposing subscriptions")
        
        if (!compositeDisposable.isDisposed) {
            compositeDisposable.dispose()
        }
    }

    // MARK: - Private Methods

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

        tableView.rowHeight = 80
        tableView.backgroundColor = .clear
        tableView.tableFooterView = footerView
        tableView.register(viewType: StarGazerTableViewCell.self)

        compositeDisposable += tableView.reactive.reloadData <~ gazersViewModel.gazersDataSource.signal.map({ _ in
            OSLogger.uiLog(message: "Reloading TableView", access: .public, type: .debug)
        })

        compositeDisposable += spinnerView.reactive.isAnimating <~ gazersViewModel.stopFetchingData.producer.map({ [weak self] (stopFetching: Bool) -> Bool in
            OSLogger.uiLog(message: "Spinner view is spinning: \(!stopFetching)", access: .public, type: .debug)

            DispatchQueue.main.async {
                if stopFetching {
                    self?.tableView.tableFooterView = UIView(frame: .zero)
                } else {
                    self?.tableView.tableFooterView = footerView
                }
            }

            return !stopFetching
        })
    }

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        customizeNavigationBar(backgroundColor: UIColor.backGrey, backButtonColor: UIColor.lightText)
    }

    private func shouldShowNetworkUnavailableMessage(_ shouldShow: Bool) {
        if shouldShow {
            showMessageView(message: "Network not available")
        } else {
            hideMessageView()
        }
    }

    private func showMessageView(message: String) {
        DispatchQueue.main.async {
            self.messageLabel.text = message
            self.messageViewHeightConstraint.constant = self.messageViewHeight

            UIView.animate(withDuration: self.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }

    private func hideMessageView() {
        DispatchQueue.main.async {
            self.messageViewHeightConstraint.constant = 0

            UIView.animate(withDuration: self.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension StarGazersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gazersViewModel.gazersDataSource.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = gazersViewModel.gazersDataSource.value[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: StarGazerTableViewCell.identifier, for: indexPath) as? StarGazerTableViewCell {
            cell.configure(with: cellModel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension StarGazersListViewController: UITableViewDelegate {
}

extension StarGazersListViewController: UITableViewDataSourcePrefetching {
    private func isLoadingCell(at indexPath: IndexPath) -> Bool {
        return indexPath.row >= (gazersViewModel.gazersDataSource.value.count - 1)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell(at:)), isNetworkConnectionAvailable {
            OSLogger.uiLog(message: "Fetching new Star Gazers", access: .public, type: .debug)
            gazersViewModel.getStarGazers()
        }
    }
}
