// FriendsUserTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с данными друга
final class FriendsUserTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
    }

    // MARK: - Private Outlets

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var friendPhotoImageView: UIImageView!
    @IBOutlet private var shadowView: ShadowView!

    // MARK: - Public Properties

    var user = User(userName: Constants.emptyText, userPhotoName: Constants.emptyText)

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFriendPhoto()
    }

    // MARK: - Public Methods

    func configureCell(user: User) {
        friendNameLabel.text = user.userName
        friendPhotoImageView.image = UIImage(named: user.userPhotoName)
        self.user = user
    }

    // MARK: - Private Methods

    private func setupFriendPhoto() {
        friendPhotoImageView.layer.cornerRadius = friendPhotoImageView.frame.width / 2
        shadowView.shadowColor = .red
    }
}
