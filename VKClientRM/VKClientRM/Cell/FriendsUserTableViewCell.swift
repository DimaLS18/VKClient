// FriendsUserTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с данными друга
final class FriendsUserTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
        static let friendPhotoOneText = "FriendPhotoOne"
    }

    // MARK: - Private Outlets

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var friendPhotoImageView: UIImageView!
    @IBOutlet private var shadowView: ShadowView!

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFriendPhoto()
    }

    // MARK: - Public Properties

    var user = User(
        userName: Constants.emptyText,
        userPhotoURLText: Constants.emptyText,
        userPhotoNames: [Constants.friendPhotoOneText],
        id: 0
    )


    // MARK: - Public Methods

    func configure(user: User) {
        friendNameLabel.text = user.userName
        vkNetworkService.setupImage(urlPath: user.userPhotoURLText, imageView: friendPhotoImageView)
        self.user = user
    }

    // MARK: - Private Methods

    private func setupFriendPhoto() {
        friendPhotoImageView.layer.cornerRadius = friendPhotoImageView.frame.width / 2
        shadowView.shadowColor = .red
    }
}
