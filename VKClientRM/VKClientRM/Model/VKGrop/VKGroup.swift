//
//  VKGroup.swift
//  VKClientRM
//
import Foundation
import RealmSwift

/// Группа на которую подписан пользователь
final class VKGroup: Object, Decodable {
    /// id пользователя
    @objc dynamic var id: Int
    /// Имя группы
    @objc dynamic var name: String
    /// Фотография группы
    @objc dynamic var photo200: String

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo200 = "photo_200"
    }
}
