// SearchGroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с данными групп в которых пользователь не состоит
final class SearchGroupTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
    }

    // MARK: - Private Outlets

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupPhotoImageView: UIImageView!

    // MARK: - Public Properties

    var group = Group(groupName: Constants.emptyText, groupPhotoName: Constants.emptyText)

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()

    // MARK: - Public Methods

    func configureCell(group: Group) {
        groupNameLabel.text = group.groupName
        vkNetworkService.setupImage(urlPath: group.groupPhotoName, imageView: groupPhotoImageView)
        self.group = group
    }
}
