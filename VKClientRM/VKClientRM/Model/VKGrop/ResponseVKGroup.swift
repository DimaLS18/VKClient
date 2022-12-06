//
//  ResponseVKGroup.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 02.12.2022.

import Foundation

/// Ответ с сервера о группе вконтакте
final class ResponseVKGroup: Decodable {
    /// Количество групп вконтакте
    let count: Int
    /// Группы вконтакте
    let items: [VKGroups]
}
