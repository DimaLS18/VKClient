//
//  Session.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 28.11.2022.
//


/// Хранитель данных о текущей сессии
struct Session {
    static var shared = Session()
    /// токен в VK
    var token = ""
    /// идентификатор пользователя ВК.
    var userId = 0

    // MARK: - Initializers

    private init() {}
}
