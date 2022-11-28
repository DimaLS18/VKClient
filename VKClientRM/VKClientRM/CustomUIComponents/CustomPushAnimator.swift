// CustomPushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация перехода вперед
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Constants

    private enum Constants {
        static let relativeDurationNumber = 1.2
        static let timeIntervalNamber = 0.2
        static let scaleFirstNUmber = -200
        static let secondNumber: CGFloat = 2
        static let zeroConstraintsNumber: CGFloat = 0
        static let scaleTransformNumber: CGFloat = 0.8
        static let withRelativeStartTimeNumber = 0.6
        static let withRelativeDuractionNumber = 0.4
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame

        let transition = CGAffineTransform(
            translationX: (source.view.frame.width / 2) + (source.view.frame.height / 2),
            y: -source.view.frame.width / 2
        )

        let rotation = CGAffineTransform(rotationAngle: 270 * .pi / 180)
        destination.view.transform = rotation.concatenating(transition)

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: Constants.zeroConstraintsNumber,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: Constants.zeroConstraintsNumber,
                relativeDuration: Constants.withRelativeDuractionNumber
            ) {
                let transition = CGAffineTransform(
                    translationX: CGFloat(Constants.scaleFirstNUmber),
                    y: Constants.zeroConstraintsNumber
                )
                let scale = CGAffineTransform(scaleX: Constants.scaleTransformNumber, y: Constants.scaleTransformNumber)
                source.view.transform = scale.concatenating(transition)
            }
            UIView.addKeyframe(
                withRelativeStartTime: Constants.timeIntervalNamber,
                relativeDuration: Constants.withRelativeDuractionNumber
            ) {
                let transition = CGAffineTransform(
                    translationX: source.view.frame.width / Constants.secondNumber,
                    y: Constants.zeroConstraintsNumber
                )
                let scale = CGAffineTransform(
                    scaleX: Constants.relativeDurationNumber,
                    y: Constants.relativeDurationNumber
                )
                source.view.transform = transition.concatenating(scale)
            }
            UIView.addKeyframe(
                withRelativeStartTime: Constants.withRelativeStartTimeNumber,
                relativeDuration: Constants.withRelativeDuractionNumber
            ) {
                destination.view.transform = .identity
            }
        } completion: { result in
            if result, !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(result && !transitionContext.transitionWasCancelled)
        }
    }
}
