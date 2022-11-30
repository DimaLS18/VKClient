// WebViewLoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Контроллер авторизации через WebKit
final class WebViewLoginViewController: UIViewController {

    private enum Constants {
        static let accessToken = "access_token"
        static let userID = "user_id"
        static let separatedBy = "&"
        static let separatedByTwo = "="
        static let blank  = "/blank.html"
        static let segueIdentifier = "menuVC"
    }

    // MARK: - Private IBOutlets

    @IBOutlet var vkWebView: WKWebView!{
        didSet {
            vkWebView.navigationDelegate = self
        }
    }

    // MARK: - Private Properties
    private var session = Session.shared
    private var vkAPIService = VKAPIService()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Private methods
    private func showAuthorizationWebView() {
        guard let authorizationURL = URL(string: NetworkRequests.authorization.urlPath) else { return }
        let request = URLRequest(url: authorizationURL)
        vkWebView.load(request)
    }

    private func initMethods() {
        showAuthorizationWebView()
    }
}
// MARK: - WKNavigationDelegate
extension WebViewLoginViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == Constants.blank, let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.separatedBy)
            .map { $0.components(separatedBy: Constants.separatedByTwo) }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        guard let token = params[Constants.accessToken],
              let userID = params[Constants.userID]
        else {
            decisionHandler(.allow)
            return
        }
        Session.shared.token = token
        Session.shared.userID = userID

        vkAPIService.printAllData()
        decisionHandler(.cancel)

        performSegue(withIdentifier: Constants.segueIdentifier, sender: nil)

    }
}
