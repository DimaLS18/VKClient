// CustomPopAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация перехода назад
final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Constants

    private enum Constants {
        static let relativeDurationNumber = 0.4
        static let timeIntervalNamber = 0.6
        static let scaleFirstNUmber = 90
        static let secondNumber: CGFloat = 2
        static let zeroConstraintsNumber: CGFloat = 0
        static let scaleTransformNumber = 1.2
        static let withRelativeStartTimeNumber = 0.25
        static let withRelativeDuractionNumber = 0.75
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.timeIntervalNamber
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        destination.view.frame = source.view.frame
        let translation = CGAffineTransform(
            translationX: -(
                source.view.frame.width / Constants.secondNumber + source.view.frame.height / Constants
                    .secondNumber
            ),
            y: -source.view.frame.width / CGFloat(Constants.secondNumber)
        )
        let scale = CGAffineTransform(rotationAngle: CGFloat(Constants.scaleFirstNUmber) * .pi / 100)
        destination.view.transform = translation.concatenating(scale)

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: Double(Constants.zeroConstraintsNumber),
                relativeDuration: Constants.relativeDurationNumber
            ) {
                let transition = CGAffineTransform(
                    translationX: source.view.frame.width / Constants.secondNumber,
                    y: CGFloat(Constants.zeroConstraintsNumber)
                )
                let scale = CGAffineTransform(scaleX: Constants.scaleTransformNumber, y: Constants.scaleTransformNumber)
                source.view.transform = transition.concatenating(scale)
            }
            UIView.addKeyframe(
                withRelativeStartTime: Constants.relativeDurationNumber,
                relativeDuration: Constants.relativeDurationNumber
            ) {
                let transition = CGAffineTransform(
                    translationX: source.view.frame.width / Constants.secondNumber,
                    y: Constants.zeroConstraintsNumber
                )
                let scale = CGAffineTransform(scaleX: Constants.scaleTransformNumber, y: Constants.scaleTransformNumber)
                source.view.transform = transition.concatenating(scale)
            }
            UIView.addKeyframe(
                withRelativeStartTime: Constants.withRelativeStartTimeNumber,
                relativeDuration: Constants.withRelativeDuractionNumber
            ) {
                destination.view.transform = .identity
            }
        } completion: { finished in
            if finished, !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
