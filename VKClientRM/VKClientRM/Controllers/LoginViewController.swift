//
//  ViewController.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 05.11.2022.
//

import UIKit
/// Экран авторизации пользователя
final class LoginViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let lightBlueColorName = "LightBlueColor"
        static let darkBlueColorName = "DarkBlueColor"
        static let whiteColorName = "WhiteColor"
        static let loginPlaceholderText = "введите Email или телефон"
        static let passwordPlaceholderText = "введите пароль"
        static let enterButtonText = "Войти"
        static let forgotPasswordButtonText = "Забыли пароль?"
        static let loginSegueIdentifier = "LoginSegue"
        static let titleAlertText = "Ошибка"
        static let messageAlertText = "Логин или пароль введены неверно"
        static let correctLoginText = "admin"
        static let correctPasswordText = "admin"
        static let okText = "OK"
        static let fontSizeForTextNumber: CGFloat = 18
    }

    // MARK: - Private Outlets

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var enterButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var mainScrollView: UIScrollView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardManager()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObserver()
    }

    // MARK: - IBAction

    @IBAction private func loginButtonAction(_ sender: UIButton) {

        if checkLoginInfo() {
            performSegue(withIdentifier: Constants.loginSegueIdentifier, sender: self)
        } else {
            showAlert(title: Constants.titleAlertText, message: Constants.messageAlertText)
        }
    }

    // MARK: - Private Methods

    @objc private func keyboardWillShown(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary,
              let keyboard = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else { return }
        let contectInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboard.cgRectValue.size.height, right: 0)
        mainScrollView.contentInset = contectInsets
        mainScrollView.scrollIndicatorInsets = contectInsets
    }

    @objc private func keyboardWillHide(notification: Notification) {
        mainScrollView.contentInset = UIEdgeInsets.zero
        mainScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboard() {
        mainScrollView.endEditing(true)
    }

    private func setupView() {
        setupMainView()
        setupLoginTextField()
        setupPasswordTextField()
        setupEnterButton()
        setupForgotPasswordButton()
    }

    private func setupMainView() {
        view.backgroundColor = UIColor(named: Constants.lightBlueColorName)
    }

    private func setupLoginTextField() {
        loginTextField.delegate = self
        loginTextField.placeholder = Constants.loginPlaceholderText
        loginTextField.font = UIFont.systemFont(ofSize: Constants.fontSizeForTextNumber)
    }

    private func setupPasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.placeholder = Constants.passwordPlaceholderText
        passwordTextField.font = UIFont.systemFont(ofSize: Constants.fontSizeForTextNumber)
        passwordTextField.isSecureTextEntry = true
    }

    private func setupEnterButton() {
        enterButton.setTitle(Constants.enterButtonText, for: .normal)
        enterButton.setTitleColor(UIColor(named: Constants.whiteColorName), for: .normal)
        enterButton.backgroundColor = UIColor(named: Constants.darkBlueColorName)
        enterButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSizeForTextNumber)
        enterButton.layer.cornerRadius = 10
    }

    private func setupForgotPasswordButton() {
        forgotPasswordButton.setTitle(Constants.forgotPasswordButtonText, for: .normal)
        forgotPasswordButton.setTitleColor(UIColor(named: Constants.whiteColorName), for: .normal)
        forgotPasswordButton.backgroundColor = UIColor(named: Constants.darkBlueColorName)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSizeForTextNumber)
        forgotPasswordButton.layer.cornerRadius = 10
    }

    private func checkLoginInfo() -> Bool {
        guard
            let loginText = loginTextField.text,
            let passwordText = passwordTextField.text,
            loginText == Constants.correctLoginText,
            passwordText == Constants.correctPasswordText
        else {
            return false
        }
        return true
    }

    private func keyboardManager() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mainScrollView.addGestureRecognizer(tapGesture)
    }

    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Alert

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
