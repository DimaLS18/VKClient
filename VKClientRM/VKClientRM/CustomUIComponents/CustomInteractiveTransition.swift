// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс отвечающий за переходы между экранами
final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Constants

    private enum Constants {
        static let shouldFinish = 0.33
        static let minNumber: Double = 0
        static let maxNumber: Double = 1
    }

    // MARK: - Public Properties

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGestureAction(_:))
            )
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    var hasStarted: Bool = false

    // MARK: - Private Properties

    private var isFinished: Bool = false

    // MARK: - Private methods

    @objc private func handleScreenEdgeGestureAction(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(Constants.minNumber, min(Constants.maxNumber, Double(Int(relativeTranslation))))
            isFinished = progress > Constants.shouldFinish
            update(progress)
        case .ended:
            hasStarted = false
            if isFinished {
                finish()
            } else {
                cancel()
            }
        case .cancelled:
            hasStarted = false
            cancel()
        default: return
        }
    }
}
