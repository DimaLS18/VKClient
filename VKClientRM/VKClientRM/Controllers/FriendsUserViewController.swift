// FriendsUserViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - typealias

typealias CharacterHandler = (Character) -> ()

/// Экран с друзьями пользователя
final class FriendsUserViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsUserCellID = "FriendsUserCell"
        static let segueID = "GoToPhotosUserCollectionVC"
        static let whiteColorName = "WhiteColor"
        static let darkBlueColorName = "DarkBlueColor"
        static let photosName: [String] = []
    }

    // MARK: - IBOutlet

    @IBOutlet private var characterSetControl: CharacterSetControl!
    @IBOutlet private var friendsTableView: UITableView!

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()
    private var users: [User] = []
    private lazy var friends = users
    private var friendsForSection: [Character: [User]] = [:]
    private var charactersName: [Character] = []
    private var personItems: [ItemPerson] = []

    private lazy var scrollFromCharacterHandler: CharacterHandler? = { [weak self] character in
        guard
            let self = self,
            let section = self.charactersName.firstIndex(of: character)
        else { return }
        let indexPath = IndexPath(row: 0, section: section)
        self.friendsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Constants.segueID,
            let destination = segue.destination as? PhotosUserCollectionViewController,
            let cell = sender as? FriendsUserTableViewCell
        else { return }
        destination.configurePhotosUserCollectionVC(currentUser: cell.user)
    }

    // MARK: - Private Methods

    private func setupView() {
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        setupCharacters()
        makeFriendsForSection()
        friends.sort {
            $0.userName < $1.userName
        }
        characterSetControl.scrollFromCharacterHandler = scrollFromCharacterHandler
        vkNetworkService.fetchFriendsVK { [weak self] items in
            guard let self = self else { return }
            for item in items {
                self.users.append(User(
                    userName: "\(item.firstName) \(item.lastName)",
                    userPhotoURLText: item.photo,
                    userPhotoNames: Constants.photosName,
                    id: item.id
                ))
            }
            self.friends = self.users
            self.setupCharacters()
            self.makeFriendsForSection()
            self.friends.sort {
                $0.userName < $1.userName
            }
            self.characterSetControl.scrollFromCharacterHandler = self.scrollFromCharacterHandler
            self.friendsTableView.reloadData()
        }
    }

    private func setupCharacters() {
        charactersName = []
        for friend in friends {
            guard
                !friend.userName.isEmpty,
                let safeChatacter = friend.userName.first,
                !charactersName.contains(safeChatacter)
            else { continue }
            charactersName.append(safeChatacter)
        }
        charactersName.sort()
        characterSetControl.characterSet = charactersName
    }

    private func makeFriendsForSection() {
        for character in charactersName {
            var friendsForCharacter: [User] = []
            for friend in friends {
                guard
                    !friend.userName.isEmpty,
                    let safeChatacter = friend.userName.first,
                    character == safeChatacter
                else { continue }
                friendsForCharacter.append(friend)
            }
            friendsForSection[character] = friendsForCharacter
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FriendsUserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        charactersName.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            section < charactersName.count,
            let countFriendsForSection = friendsForSection[charactersName[section]]?.count
        else { return 0 }
        return countFriendsForSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.friendsUserCellID,
                for: indexPath
            ) as? FriendsUserTableViewCell,
            indexPath.row < friends.count,
            indexPath.section < charactersName.count,
            let friendsForSection = friendsForSection[charactersName[indexPath.section]]
        else { return UITableViewCell() }
        cell.configure(user: friendsForSection[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < charactersName.count else { return nil }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel()
        headerView.backgroundColor = UIColor(named: Constants.darkBlueColorName)?.withAlphaComponent(0.5)
        label.frame = CGRect(x: 19, y: 5, width: headerView.frame.width - 38, height: headerView.frame.height - 10)
        label.text = "\(charactersName[section])"
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(named: Constants.whiteColorName)
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}

// MARK: - UISearchBarDelegate

extension FriendsUserViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        friends = users
        if searchText.isEmpty {
            searchBar.endEditing(true)
        } else {
            friends = friends.filter { user in
                user.userName.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        setupCharacters()
        makeFriendsForSection()
        friendsTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
