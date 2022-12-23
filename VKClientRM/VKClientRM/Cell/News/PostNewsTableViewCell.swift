// PostNewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Новость типа пост
final class PostNewsTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let zeroNumber = 0
        static let threeNumber = 3
        static let showLessText = "Show less..."
        static let showMoreText = "Show more..."
    }
    
    @IBOutlet private var postLabel: UILabel!
    @IBOutlet private var showTextButton: UIButton!
    
    // MARK: - Public Properties
    
    weak var delegate: PostNewsTableCellDelegate?
    
    var isExpanded = false {
        didSet {
            updateCell()
        }
    }
    
    // MARK: - Public Methods
    
    func configure(news: Newsfeed) {
        postLabel.text = news.text
        updateCell()
    }
    
    // MARK: - Private Action
    
    @IBAction private func showTextAction(_ sender: UIButton) {
        delegate?.didTappedShowTextButton(cell: self)
    }
    
    // MARK: - Private Methods
    
    private func updateCell() {
        postLabel.numberOfLines = isExpanded ? Constants.zeroNumber : Constants.threeNumber
        let title = isExpanded ? Constants.showLessText : Constants.showMoreText
        showTextButton.setTitle(title, for: .normal)
    }
}
