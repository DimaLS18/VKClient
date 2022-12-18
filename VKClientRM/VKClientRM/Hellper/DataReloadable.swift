//
//  DataReloadable.swift
//  VKClientRM

import Alamofire
import Foundation
/// Протокол, декларирующий метод по перезагрузки ячейки
protocol DataReloadable {
    func reloadRow(at indexPath: IndexPath)
}
