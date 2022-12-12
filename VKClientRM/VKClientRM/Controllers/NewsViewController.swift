// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

//
//  NewsViewController.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 09.11.2022.
//
import UIKit
/// Экран с новостной лентой
final class NewsViewController: UIViewController {
    // MARK: - Constants
    
    private enum Constants {
        static let newsTableViewCellID = "NewsTableViewCell"
        static let firstUserName = "Егор"
        static let firstUserPhotoName = "FriendPhotoOne"
        static let firstUserNewsDateText = "29.05.2022"
        static let firstUserNewsText = "Кубок наш"
        static let firstUserNewsImagesName = ["NewsFotoOne", "NewsFotoTwo"]
        static let firstUserNewsLikeCount = 1922
        static let secondUserName = "Дмитрий"
        static let secondUserPhotoName = "FriendPhotoSecond"
        static let secondUserNewsDateText = "30.05.2022"
        static let secondUserNewsText = "Друзья"
        static let secondUserNewsImagesName = [
            "FriendPhotoOne",
            "FriendPhotoSecond",
            "FriendPhotoThird",
            "NewsFotoFive"
        ]
        static let secondUserNewsLikeCount = 18
        static let thirdUserName = "Роман"
        static let thirdUserPhotoName = "FriendPhotoThird"
        static let thirdUserNewsDateText = "30.05.2022"
        static let thirdUserNewsText = "А кому сейчас легко"
        static let thirdUserNewsImagesName = ["FriendPhotoFour"]
        static let thirdUserNewsLikeCount = 120
    }
    
    // MARK: - Private Outlets
    
    @IBOutlet private var newsTableView: UITableView!
    
    // MARK: - Private Properties
    
    private var allNews = [
        News(
            userName: Constants.firstUserName,
            userPhotoName: Constants.firstUserPhotoName,
            userNewsDateText: Constants.firstUserNewsDateText,
            newsText: Constants.firstUserNewsText,
            newsImagesName: Constants.firstUserNewsImagesName,
            newsLikeCount: Constants.firstUserNewsLikeCount
        ),
        News(
            userName: Constants.secondUserName,
            userPhotoName: Constants.secondUserPhotoName,
            userNewsDateText: Constants.secondUserNewsDateText,
            newsText: Constants.secondUserNewsText,
            newsImagesName: Constants.secondUserNewsImagesName,
            newsLikeCount: Constants.secondUserNewsLikeCount
        ),
        News(
            userName: Constants.thirdUserName,
            userPhotoName: Constants.thirdUserPhotoName,
            userNewsDateText: Constants.thirdUserNewsDateText,
            newsText: Constants.thirdUserNewsText,
            newsImagesName: Constants.thirdUserNewsImagesName,
            newsLikeCount: Constants.thirdUserNewsLikeCount
        )
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.register(
            UINib(nibName: Constants.newsTableViewCellID, bundle: nil),
            forCellReuseIdentifier: Constants.newsTableViewCellID
        )
    }
    
    
    private func fetchUserNewsVK() {
        vkNetworkService.fetchUserNewsVK { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .fulfilled(response):
                self.userNews = []
                for item in response where (item.type == .post) || (item.type == .photo) {
                    self.userNews.append(item)
                }
                self.newsTableView.reloadData()
            case let .rejected(error):
                self.showErrorAlert(alertTitle: nil, message: error.localizedDescription, actionTitle: nil)
            }
        }
        
        private func hightCellForImageCollection(numberRow: Int) -> CGFloat {
            guard numberRow < allNews.count else { return 0 }
            switch allNews[numberRow].newsImagesName.count {
            case 1:
                return view.bounds.width
            case let count where count > 1:
                return (view.bounds.width / 2) * CGFloat(lroundf(Float(allNews[numberRow].newsImagesName.count) / 2))
            default:
                return 0
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsTableViewCellID,
                for: indexPath
            ) as? NewsTableViewCell,
            indexPath.row < allNews.count
        else { return UITableViewCell() }

        cell.configureCell(
            news: allNews[indexPath.row],
            viewHight: hightCellForImageCollection(numberRow: indexPath.row)
        )
        return cell
    }
}
