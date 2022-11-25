// NetworkService.swift
// Copyright © RoadMap. All rights reserved.


import Alamofire
import Foundation

 /// NetworkService - класс для работы с сетью
 final class NetworkService {
     // MARK: - Constants

     private enum Constants {
         static let baseUrl = "https://api.vk.com"
         static let path = "/method"
         static let userID = "user_id"
         static let accessToken = "access_token"
         static let extended = "extended"
         static let ownerId = "owner_id"
         static let vKey = "v"
         static let qKey = "q"
         static let extendedValue = "1"
         static let ownerIDValue = "-25380626"
         static let vValue = "5.131"
         static let qValue = "i"
     }

     enum Methods: String {
         case groups = "/groups.get"
         case searchGroups = "/groups.search"
         case friendsList = "/friends.get"
         case photo = "/photos.getAll"
     }

     // MARK: - Public Properties

     static let instance = NetworkService()

     var token: String?
     var userId: String?

     // MARK: - Private Initializers

     private init() {}

     // MARK: - Public Method

     func fetchRequest(request: Methods) {
         guard
             let token = token,
             let userId = userId
         else {
             return
         }

         let parameters: Parameters = [
             Constants.userID: userId,
             Constants.accessToken: token,
             Constants.extended: Constants.extendedValue,
             Constants.ownerId: Constants.ownerIDValue,
             Constants.vKey: Constants.vValue,
             Constants.qKey: Constants.qValue
         ]

         let url = "\(Constants.baseUrl)\(Constants.path)\(request.rawValue)"
         AF.request(url, parameters: parameters).responseJSON(completionHandler: { response in
             guard let responses = response.value else { return }
             print(responses)
         })
     }
 }
