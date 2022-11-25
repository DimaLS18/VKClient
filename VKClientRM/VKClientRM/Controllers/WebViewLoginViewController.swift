// WebViewLoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Контроллер авторизации через WebKit
final class WebViewLoginViewController: UIViewController {

    private enum Constants {
        static let storyboardName = "Main"
        static let loginVCIdentifier = "tabBarID"
        static let tokenKey = "access_token"
        static let userIdKey = "user_id"
        static let scheme = "https"
        static let host = "oauth.vk.com"
        static let path = "/authorize"
        static let clientIDKey = "client_id"
        static let clientIDValue = "8223277"
        static let displayKey = "display"
        static let displayValue = "mobile"
        static let redirectKey = "redirect_uri"
        static let redirectValue = "https://oauth.vk.com/blank.html"
        static let scopeKey = "scope"
        static let scopeValue = "262150"
        static let responseTypeKey = "response_type"
        static let responseTypeValue = "token"
        static let vKey = "v"
        static let vValue = "5.131"
        static let urlPath = "/blank.html"
        static let ampersand = "&"
        static let equal = "="
    }

    // MARK: - Private IBOutlets

    @IBOutlet var vkWebView: WKWebView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
          super.viewDidLoad()
          loadWebView()
      }

      // MARK: - Private Method

      private func loadWebView() {
          vkWebView.navigationDelegate = self

          var urlComponents = URLComponents()
          urlComponents.scheme = Constants.scheme
          urlComponents.host = Constants.host
          urlComponents.path = Constants.path
          urlComponents.queryItems = [
              URLQueryItem(name: Constants.clientIDKey, value: Constants.clientIDValue),
              URLQueryItem(name: Constants.displayKey, value: Constants.displayValue),
              URLQueryItem(name: Constants.redirectKey, value: Constants.redirectValue),
              URLQueryItem(name: Constants.scopeKey, value: Constants.scopeValue),
              URLQueryItem(name: Constants.responseTypeKey, value: Constants.responseTypeValue),
              URLQueryItem(name: Constants.vKey, value: Constants.vValue)
          ]
          guard let url = urlComponents.url else { return }
          let request = URLRequest(url: url)
          vkWebView.load(request)
      }

      private func transitionToLoginVC() {
          let storyBoard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
          let tabBarVC = storyBoard.instantiateViewController(withIdentifier: Constants.loginVCIdentifier)
          tabBarVC.modalPresentationStyle = .fullScreen
          present(tabBarVC, animated: true)
      }
  }

  // MARK: - WKNavigationDelegate

  extension WebViewLoginViewController: WKNavigationDelegate {
      func webView(
          _ webView: WKWebView,
          decidePolicyFor navigationResponse: WKNavigationResponse,
          decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
      ) {
          guard
              let url = navigationResponse.response.url,
              url.path == Constants.urlPath,
              let fragment = url.fragment()
          else {
              decisionHandler(.allow)
              return
          }

          let params = fragment
              .components(separatedBy: Constants.ampersand)
              .map { $0.components(separatedBy: Constants.equal) }
              .reduce([String: String]()) { result, param in
                  var dict = result
                  let key = param[0]
                  let value = param[1]
                  dict[key] = value
                  return dict
              }
          guard
              let token = params[Constants.tokenKey],
              let userId = params[Constants.userIdKey]
          else {
              return
          }
          NetworkService.instance.token = token
          NetworkService.instance.userId = userId
          transitionToLoginVC()
          decisionHandler(.cancel)
      }
  }
