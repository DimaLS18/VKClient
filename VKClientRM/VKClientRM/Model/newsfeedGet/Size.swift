// Size.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Size: Decodable {
     /// ссылка по которой хранится фотография
     let url: String
     /// Ширина фотографии
     let width: Int
     /// Высота фотографии
     let height: Int
     /// Соотношение сторон у фотографии
     var aspectRatio: Float {
         Float(height) / Float(width)
     }

     // MARK: - CodingKeys

     enum CodingKeys: String, CodingKey {
         case url
         case width
         case height
     }
 }
