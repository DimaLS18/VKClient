//
//  66.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 10.12.2022.
//

import Foundation
/// форматирование даты
extension DateFormatter {
    // MARK: - Constants
    
    private enum Constants {
        static let dateFormatText = "HH:mm   dd MMMM"
    }
    
    // MARK: - Public Methods
    
    static func getNewsDate(dateInt: Int) -> String {
        let date = Date(timeIntervalSinceReferenceDate: Double(dateInt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatText
        return dateFormatter.string(from: date)
    }
}
