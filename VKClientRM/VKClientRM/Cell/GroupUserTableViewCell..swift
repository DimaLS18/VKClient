// GroupUserTableViewCell..swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с данными групп в которых пользователь  состоит
final class GroupUserTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
    }

    // MARK: - Private Outlets

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupPhotoImageView: UIImageView!

    // MARK: - Public Properties

    var group = Group(groupName: Constants.emptyText, groupPhotoName: Constants.emptyText)

    // MARK: - Public Methods

    func configureCell(group: Group) {
        groupNameLabel.text = group.groupName
        groupPhotoImageView.image = UIImage(named: group.groupPhotoName)
        self.group = group
    }
}
