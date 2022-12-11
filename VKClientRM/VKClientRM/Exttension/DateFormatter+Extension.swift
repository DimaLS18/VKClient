//
//  66.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 10.12.2022.
//

import Foundation


/// Форматирование даты
extension DateFormatter {
    static let bigDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
        return formatter
    }()
}
