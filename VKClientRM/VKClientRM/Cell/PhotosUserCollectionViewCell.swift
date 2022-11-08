// PhotosUserCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фотографией друга
final class PhotosUserCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Outlets

    @IBOutlet private var friendPhotoImageView: UIImageView!

    // MARK: - Public Methods

    func configureCell(userPhoto: String) {
        friendPhotoImageView.image = UIImage(named: userPhoto)
    }
}
