//
//  UIViewController+Extension.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 07.11.2022.
//

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
