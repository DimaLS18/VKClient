// CustomNavigationController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension CustomNavigationController: UINavigationControllerDelegate {
    // MARK: - Private Methods

    func setupNavigationController() {
        delegate = self
    }
}
