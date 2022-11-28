//
//  Session.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 28.11.2022.
//

import Foundation
/// Информация о сессии юзера
final class Session {
    // MARK: - Public Properties

    static let shared = Session()
    var userID = ""
    var token = ""

    // MARK: - Initializers

    private init() {}
}
