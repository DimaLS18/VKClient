// NetworkService.swift
// Copyright © RoadMap. All rights reserved.


import Alamofire
import Foundation

/// Менеджер сетевых запросов по API VK
/// Апи запросы
struct VKAPIService: LoadNetworkDataProtocol {
    // MARK: - Private Constants
    private enum Constants {
        static let groupSearchParam = "SwiftDevelop"
    }
    
    // MARK: - Public methods
    func printAllData() {
        fetchFriends()
        fetchUserPhotos(for: Session.shared.userID)
        fetchUserGroups(for: Session.shared.userID)
        fetchPublicGroups()
    }
    
    // MARK: - Private methods
    private func fetchFriends() {
        loadData(urlPath: NetworkRequests.friends.urlPath)
    }
    
    private func fetchUserPhotos(for userID: String) {
        loadData(urlPath: NetworkRequests.photos(userID: userID).urlPath)
    }
    
    private func fetchUserGroups(for userID: String) {
        loadData(urlPath: NetworkRequests.groups(userID: userID).urlPath)
    }
    private func fetchPublicGroups() {
        loadData(urlPath: NetworkRequests.globalGroups(query: Constants.groupSearchParam).urlPath)
    }

    func downloadImageFrom(urlString: URL, completion: @escaping (UIImage) -> Void) {
            let task = URLSession.shared.dataTask(with: urlString) { data, _, error in
                if error != nil {
                    print("ERROR \(String(describing: error))")
                }
                guard let data = data,
                      let downloadedImage = UIImage(data: data) else { return }
                completion(downloadedImage)
            }
            task.resume()
        }
}
