// FriendsUserTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с данными друга
final class FriendsUserTableViewCell: UITableViewCell {

    // MARK: - Private Outlets

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var friendPhotoImageView: UIImageView!
    @IBOutlet private var shadowView: ShadowView!


    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFriendPhoto()
    }

    // MARK: - Public Properties

    var itemPerson = ItemPerson()

    // MARK: - Public Methods

    func configure(user: ItemPerson, photoService: PhotoService) {
        friendNameLabel.text = user.fullName
        friendPhotoImageView.image = image
        self.itemPerson = user
    }

    // MARK: - Private Methods

    private func setupFriendPhoto() {
        selectionStyle = .none
        friendPhotoImageView.layer.cornerRadius = friendPhotoImageView.frame.width / 2
        shadowView.shadowColor = .blue
    }
}
