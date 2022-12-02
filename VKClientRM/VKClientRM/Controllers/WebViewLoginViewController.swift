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
        static let friendsGetText = "friends.get"
        static let photosGetAllText = "photos.getAll"
        static let ownerIdText = "owner_id"
        static let groupsGetText = "groups.get"
        static let groupsSearchText = "groups.search"
        static let qText = "q"
    }

    // MARK: - Private IBOutlets

    @IBOutlet var vkWebView: WKWebView!{
        didSet {
            vkWebView.navigationDelegate = self
        }
    }

    // MARK: - Private properties

    private let vkNetworkService = VKNetworkService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }

    // MARK: - Private Methods

    private func loadWebView() {
        let urlComponents = vkNetworkService.createUrlComponents()
        guard let safeURL = urlComponents.url else { return }
        let request = URLRequest(url: safeURL)
        vkWebView.load(request)
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
        guard let url = navigationResponse.response.url, url.path == Constants.blank,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.separatedBy)
            .map { $0.components(separatedBy: Constants.separatedByTwo) }.reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params[Constants.accessToken]
        let userId = params[Constants.userID]
        guard let safeToken = token, let userIdString = userId, let safeUserId = Int(userIdString) else { return }
        Session.shared.token = safeToken
        Session.shared.userId = safeUserId
        decisionHandler(.cancel)
        performSegue(withIdentifier: Constants.segueIdentifier, sender: self)
    }
}
