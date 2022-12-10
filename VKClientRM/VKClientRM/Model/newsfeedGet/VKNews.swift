// VKNews.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список новостей текущего пользователя
final class VKNews: Decodable {
  ///  Ответ с сервера о новостях текущего пользователя
    let response: ResponseVKNews
}
