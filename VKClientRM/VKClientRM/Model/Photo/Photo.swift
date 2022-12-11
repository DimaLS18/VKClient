// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Фотография
final class Photo: Decodable {
    /// Ответ с сервера о фотографии
    let response: ResponsePhoto
}
