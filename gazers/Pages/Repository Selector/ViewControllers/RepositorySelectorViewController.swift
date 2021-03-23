//
//  RepositorySelectorViewController.swift
//  gazers
//
//  Created by Nicolò Pasini on 20/03/21.
//

import UIKit
import OSLogger

class RepositorySelectorViewController: BaseViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var repoDetailsView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var repoNameText: UITextField!
    @IBOutlet weak var repoOwnerText: UITextField!

    private var activeTextField: UITextField?
    private let navigationService: NavigationService?

    var repositoryViewModel: RepositorySelectorViewModel {
        if viewModel is RepositorySelectorViewModel {
            return viewModel as! RepositorySelectorViewModel
        } else {
            fatalError("The View Model has the wrong type")
        }
    }

    // MARK: - Life Cycle

    required init?(coder: NSCoder) {
        let viewModel = RepositorySelectorViewModel()
        navigationService = AssemblerWrapper.shared.resolve(NavigationService.self)

        super.init(coder: coder, viewModel: viewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        repoNameText.delegate = self
        repoOwnerText.delegate = self

        setupLayout()
        registerForKeyboardNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotification()
    }

    @IBAction func submitRepoDetails() {
        activeTextField?.resignFirstResponder()

        if viewModel.isValid() {
            navigateToGazerListPage()
        } else {
            showErrorMessage()
        }
    }

    // MARK: - Keyboard Methods
    private func registerForKeyboardNotification() {
        OSLogger.uiLog(message: "Registering from keyboard notifications", access: .public, type: .debug)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unregisterForKeyboardNotification() {
        OSLogger.uiLog(message: "Unregistering from keyboard notifications", access: .public, type: .debug)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardDidShow(notification: NSNotification) {
        let notificationInfo = notification.userInfo
        if let keyboardSize = notificationInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset

            // If active text field is hidden by keyboard, scroll it so it's visible
            var screenFrame = self.view.frame
            screenFrame.size.height -= keyboardSize.height;
            if let activeField = activeTextField, !screenFrame.contains(activeField.frame.origin) {
                scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }

    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    // MARK: - Private Methods

    private func setupLayout() {
        confirmButton.layer.cornerRadius = 20
        repoDetailsView.layer.cornerRadius = 20
    }

    private func showErrorMessage() {
        let alert = UIAlertController(title: "Error", message: viewModel.errorMessage(), preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)

        navigationController?.present(alert, animated: true, completion: nil)
    }

    private func navigateToGazerListPage() {
        OSLogger.uiLog(message: "Navigating to Star Gazers list page", access: .public, type: .debug)
        let starGazerListViewModel = StarGazersListViewModel(repositoryName: repositoryViewModel.repositoryName, repositoryOwner: repositoryViewModel.repositoryOwner)
        navigationService?.push(page: .starGazerList, with: starGazerListViewModel, using: navigationController)
    }
}

// MARK: - TextField Delegate

extension RepositorySelectorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveInsertedData(in: textField)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveInsertedData(in: textField)
        textField.resignFirstResponder()
        return true
    }

    private func saveInsertedData(in textField: UITextField) {
        if let text = textField.text {
            if textField == repoNameText {
                OSLogger.uiLog(message: "Set repo name to: \(text)", access: .public, type: .debug)
                repositoryViewModel.setRepositoryName(text)
            }

            if textField == repoOwnerText {
                OSLogger.uiLog(message: "Set repo owner to: \(text)", access: .public, type: .debug)
                repositoryViewModel.setRepositoryOwner(text)
            }
        }
    }
}
