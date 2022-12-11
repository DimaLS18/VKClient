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

    var group = VKGroups()

    // MARK: - Private Properties

    private let vkNetworkService = VKNetworkService()

    // MARK: - Public Methods

    func configure(group: VKGroups, vkNetworkService: VKNetworkService) {
        selectionStyle = .none
        groupNameLabel.text = group.name
        groupPhotoImageView.setupImage(urlPath: group.photo200, networkService: vkNetworkService)
        self.group = group
    }
}
