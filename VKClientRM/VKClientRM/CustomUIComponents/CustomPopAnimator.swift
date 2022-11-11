// CustomPopAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация перехода назад
final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.6
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
            translationX: -(source.view.frame.width / 2 + source.view.frame.height / 2),
            y: -source.view.frame.width / 2
        )
        let scale = CGAffineTransform(rotationAngle: 90 * .pi / 100)
        destination.view.transform = translation.concatenating(scale)

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                let transition = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                source.view.transform = transition.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4) {
                let transition = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                source.view.transform = transition.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
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
