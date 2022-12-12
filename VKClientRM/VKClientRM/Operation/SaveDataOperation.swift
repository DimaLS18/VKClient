//
//  SaveDataOperation.swift
//  VKClientRM

import Foundation

 /// Сохранение данных
 final class SaveDataOperation: Operation {
     // MARK: - Private Properties

     private let realmService = RealmService()

     // MARK: - Public Methods

     override func main() {
         guard let getParseData = dependencies.first as? ParseDataOperation else { return }
         let parseData = getParseData.itemPersons
         realmService.saveFriendsData(parseData)
     }
 }
