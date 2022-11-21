// AnimatedFotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран просмотра фотографий в большом виде
final class AnimatedFotoViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let withDurationNunber = 0.6
        static let numberZero = 0
        static let relativeDurationNumber = 0.5
        static let photoConstraintNumber = 50
        static let firstNumber = 1
        static let secondNumber = 2
    }

    // MARK: - Private Outlets

    @IBOutlet private var currentUserPhotoImageView: UIImageView!
    @IBOutlet private var nextUserPhotoImageView: UIImageView!
    @IBOutlet private var currentUserPhotoTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var currentUserPhotoLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var nextUserPhotoLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var nextUserPhotoTrailingConstraint: NSLayoutConstraint!

    // MARK: - Private Properties

    private var userPhotosName: [String] = []
    private var currentUserPhotoIndex = 0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func configureBigPhotosUserVC(currentUserPhotoIndex: Int, userPhotosName: [String]) {
        self.userPhotosName = userPhotosName
        self.currentUserPhotoIndex = currentUserPhotoIndex
    }

    // MARK: - Private Methods

    @objc private func didSwipeAction(gesture: UIGestureRecognizer) {
        guard let swipeGesture = gesture as? UISwipeGestureRecognizer else { return }
        switch swipeGesture.direction {
        case .right:
            guard
                currentUserPhotoIndex < userPhotosName.count,
                currentUserPhotoIndex > 0
            else { return }
            doAnimationForSwipeRight()
        case .left:
            guard
                currentUserPhotoIndex < userPhotosName.count - 1,
                currentUserPhotoIndex >= 0
            else { return }
            doAnimationForSwipeLeft()
        default:
            break
        }
    }

    private func setupView() {
        addSwipeToView()
        setupImageViews()
    }

    private func doAnimationForSwipeLeft() {
        prepareForAnimationForSwipeLeft()
        UIView.animateKeyframes(
            withDuration: Constants.withDurationNunber,
            delay: TimeInterval(Constants.numberZero),
            options: []
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: Double(Constants.numberZero),
                relativeDuration: Constants.relativeDurationNumber
            ) {
                self.currentUserPhotoTrailingConstraint.constant = CGFloat(Constants.photoConstraintNumber)
                self.currentUserPhotoLeadingConstraint.constant = CGFloat(Constants.photoConstraintNumber)
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(
                withRelativeStartTime: Constants.relativeDurationNumber,
                relativeDuration: Constants.relativeDurationNumber
            ) {
                self.view.layoutIfNeeded()
                self.nextUserPhotoTrailingConstraint.constant = CGFloat(Constants.numberZero)
                self.nextUserPhotoLeadingConstraint.constant = CGFloat(Constants.numberZero)
                self.view.layoutIfNeeded()
            }
        }
    }

    private func prepareForAnimationForSwipeLeft() {
        currentUserPhotoTrailingConstraint.constant = CGFloat(Constants.numberZero)
        currentUserPhotoLeadingConstraint.constant = CGFloat(Constants.numberZero)
        currentUserPhotoImageView.layer.zPosition = CGFloat(Constants.firstNumber)
        currentUserPhotoImageView.image = UIImage(named: userPhotosName[currentUserPhotoIndex])
        nextUserPhotoTrailingConstraint.constant = -view.frame.width
        nextUserPhotoLeadingConstraint.constant = view.frame.width
        nextUserPhotoImageView.layer.zPosition = CGFloat(Constants.secondNumber)
        nextUserPhotoImageView.image = UIImage(named: userPhotosName[currentUserPhotoIndex + Constants.firstNumber])
        view.layoutIfNeeded()
        currentUserPhotoIndex += Constants.firstNumber
    }

    private func doAnimationForSwipeRight() {
        prepareForAnimationForSwipeRight()
        UIView.animateKeyframes(
            withDuration: Constants.withDurationNunber,
            delay: TimeInterval(Constants.numberZero),
            options: []
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: Double(Constants.numberZero),
                relativeDuration: Constants.relativeDurationNumber
            ) {
                self.currentUserPhotoTrailingConstraint.constant = -self.view.frame.width
                self.currentUserPhotoLeadingConstraint.constant = self.view.frame.width
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(
                withRelativeStartTime: Constants.relativeDurationNumber,
                relativeDuration: Constants.relativeDurationNumber
            ) {
                self.view.layoutIfNeeded()
                self.nextUserPhotoTrailingConstraint.constant = CGFloat(Constants.numberZero)
                self.nextUserPhotoLeadingConstraint.constant = CGFloat(Constants.numberZero)
                self.view.layoutIfNeeded()
            }
        }
    }

    private func prepareForAnimationForSwipeRight() {
        currentUserPhotoTrailingConstraint.constant = CGFloat(Constants.numberZero)
        currentUserPhotoLeadingConstraint.constant = CGFloat(Constants.numberZero)
        currentUserPhotoImageView.layer.zPosition = CGFloat(Constants.secondNumber)
        currentUserPhotoImageView.image = UIImage(named: userPhotosName[currentUserPhotoIndex])
        nextUserPhotoTrailingConstraint.constant = CGFloat(Constants.photoConstraintNumber)
        nextUserPhotoLeadingConstraint.constant = CGFloat(Constants.photoConstraintNumber)
        nextUserPhotoImageView.layer.zPosition = CGFloat(Constants.firstNumber)
        nextUserPhotoImageView.image = UIImage(named: userPhotosName[currentUserPhotoIndex - Constants.firstNumber])
        view.layoutIfNeeded()
        currentUserPhotoIndex -= Constants.firstNumber
    }

    private func setupImageViews() {
        guard 0 ..< userPhotosName.count ~= currentUserPhotoIndex else { return }
        currentUserPhotoImageView.image = UIImage(named: userPhotosName[currentUserPhotoIndex])
    }

    private func addSwipeToView() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeAction(gesture:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeAction(gesture:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
}
