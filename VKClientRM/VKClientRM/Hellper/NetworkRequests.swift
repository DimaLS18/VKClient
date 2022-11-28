//
//  Session.swift
//  VKClientRM
//

import Foundation

/// Сетевой запрос
enum NetworkRequests {
    // MARK: - Constants
    private enum Constants {
        static let baseURL = "https://api.vk.com/method/"
        static let authorizeBaseURL = "https://oauth.vk.com/authorize"
        static let accessToken = "?access_token="
        static let friendFields = "&fields=nickname"
        static let version = "&v=5.131"
        static let withExtendedParam = "&extended=1"
        static let ownerIdParam = "&owner_id="
        static let userIdParam = "&user_id="
        static let queryParam = "&q="
        static let friendsRequest = "friends.get"
        static let photosRequest = "photos.getAll"
        static let groupsRequest = "groups.get"
        static let globalGroupsRequest = "groups.search"
        static let redirectURI = "redirect_uri"
        static let redirectValue = "https://oauth.vk.com/blank.html"
        static let clientID = "?client_id="
        static let clientIDValue = "8223277"
        static let display = "&display="
        static let displayValue = "mobile"
        static let scope = "&scope="
        static let scopeValue = "262150"
        static let responseType = "&response_type="
        static let responseTypeValue = "token"
    }
    
    case authorization
    case friends
    case photos(userID: String)
    case groups(userID: String)
    case globalGroups(query: String)
    
    // MARK: - Public Properties
    var urlPath: String {
        switch self {
        case .authorization:
            return authorizationURL()
        case .friends:
            return baseURLWithMethod(Constants.friendsRequest) + Constants.friendFields
        case let .photos(userID):
            return baseURLWithMethod(Constants.photosRequest) + Constants.ownerIdParam + userID + Constants
                .withExtendedParam
        case let .groups(userID):
            return baseURLWithMethod(Constants.groupsRequest) + Constants.userIdParam + userID + Constants
                .withExtendedParam
        case let .globalGroups(query):
            return baseURLWithMethod(Constants.globalGroupsRequest) + Constants.queryParam + query + Constants
                .withExtendedParam
        }
    }
    
    // MARK: - Private Methods
    private func baseURLWithMethod(_ method: String) -> String {
        Constants.baseURL + method + Constants.accessToken + Session.shared.token + Constants.version
    }
    
    private func authorizationURL() -> String {
        Constants.authorizeBaseURL + Constants.clientID + Constants.clientIDValue + Constants.display + Constants
            .displayValue + Constants.scope + Constants.scopeValue + Constants.responseType + Constants
            .responseTypeValue
    }
}
