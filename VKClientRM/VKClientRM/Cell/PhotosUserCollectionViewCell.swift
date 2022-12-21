// PhotosUserCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фотографией пользователя
final class PhotosUserCollectionViewCell: UICollectionViewCell {

    // MARK: - Private Outlets

    @IBOutlet private var friendPhotoImageView: UIImageView!


    // MARK: - Public Methods

    func configure(url: String, photoService: PhotoService?) {
        friendPhotoImageView.image = photoService?.photo(atIndexpath: indexPath, byUrl: url)
    }

    func animateShowFriendPhotoImageView() {
        func animateShowFriendPhotoImageView(animationService: AnimationService) {
            animationService.animateShowImageView(imageView: friendPhotoImageView)
        }

        func animateHideFriendPhotoImageView() {
            func animateHideFriendPhotoImageView(animationService: AnimationService) {
                animationService.animateHideImageView(imageView: friendPhotoImageView)
        }

        // MARK: - Private Methods

        private func setupAnimation(animation: CABasicAnimation, fromValue: Double, toValue: Double, duration: Double) {
            animation.fromValue = fromValue
            animation.toValue = toValue
            animation.duration = duration
        }
    }
