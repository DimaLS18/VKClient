// NetworkService.swift
// Copyright © RoadMap. All rights reserved.


import Foundation
import RealmSwift

/// Менеджер работы с RealmSwift
struct RealmService {
    // MARK: - Public Methods

    func saveGroupVKData(_ groupVK: [VKGroups]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groupVK)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveFriendsData(_ friends: [ItemPerson]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    func savePhotosData(_ photos: [ItemPhoto]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photos)
            try realm.commitWrite()
        } catch {}
    }

    func loadData<T: Object>(objectType: T.Type) -> Results<T>? {
           do {
               let realm = try Realm()
               let results = realm.objects(objectType)
               return results
           } catch {}
           return nil
       }
}
