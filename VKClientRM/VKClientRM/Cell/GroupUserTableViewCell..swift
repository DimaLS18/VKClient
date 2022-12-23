// GroupUserTableViewCell..swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группой и фотографией группы в которых пользователь не состоит
final class GroupUserTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
        static let transformScaleText = "transform.scale"
    }

    // MARK: - Private Outlets

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupPhotoImageView: UIImageView!


    // MARK: - Public Methods

    func configure(group: VKGroups, photoService: PhotoService?)  {
        selectionStyle = .none
        groupNameLabel.text = group.name
        groupPhotoImageView.image = photoService?.photo(byUrl: group.photo200)
    }

    func animateGroupPhotoImageView(animationService: AnimationService) {
         animationService.animateJumpImageView(imageView: groupPhotoImageView)
     }
}


