//
//  LoadNetworkDataProtocol.swift
//  VKClientRM
//

import Alamofire
import Foundation

/// Протокол закгрузки данных
protocol LoadNetworkDataProtocol {
    func loadData(urlPath: String)
}

// MARK: - Реализация протокола
extension LoadNetworkDataProtocol {
    func loadData(urlPath: String) {
        AF.request(urlPath).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
}
