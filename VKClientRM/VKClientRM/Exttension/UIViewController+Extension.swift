// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// алерт
extension UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let okText = "OK"
    }

    // MARK: - Public Methods

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.okText, style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}
