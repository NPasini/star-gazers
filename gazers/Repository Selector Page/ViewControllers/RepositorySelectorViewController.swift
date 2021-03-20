//
//  RepositorySelectorViewController.swift
//  gazers
//
//  Created by Nicolò Pasini on 20/03/21.
//

import UIKit

class RepositorySelectorViewController: UIViewController {

    @IBOutlet weak var repoDetailsView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var repoNameText: UITextField!
    @IBOutlet weak var repoOwnerText: UITextField!

    private var activeTextField: UITextField?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        registerForKeyboardNotification()

        confirmButton.layer.cornerRadius = 20
        repoDetailsView.layer.cornerRadius = 20
    }

    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotification()
    }

    @IBAction func submitRepoDetails() {
    }

    // MARK: - Private Methods
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unregisterForKeyboardNotification() {
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
}
