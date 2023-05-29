//
//  HorizontalReviewTableViewCell.swift
//  BookMyTable
//
//  Created by Evelina on 28.05.2023.
//

import UIKit

class HorizontalReviewCollectionViewCell: UICollectionViewCell {

    // MARK: - Private constants
    private enum UIConstants {
        static let amountLabelFontSize: CGFloat = 20
        static let xStackSpacing: CGFloat = 14
        static let yStackSpacing: CGFloat = 4
        static let contentInset: CGFloat = 6
        static let restaurantImageHeight: CGFloat = 110
        static let restaurantImageWidth: CGFloat = 140
        static let viewsCornerSize: CGFloat = 14
        static let ratingViewWidth: CGFloat = 60
        static let ratingViewHeight: CGFloat = 30
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public function
    func configure(with review: ReviewData) {
        authorLabel.text = review.author
        commentLabel.text = review.comment
        ratingLabel.text = getStringRating(rating: review.rate)
        dateLabel.text = review.date
    }
    
    //MARK: - Private UI properties
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.amountLabelFontSize, weight: .bold)
        return label
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
//        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Private function
    private func initialize() {
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.alignment = .leading
        yStack.distribution = .equalSpacing
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.alignment = .leading
        xStack.distribution = .fill
        xStack.spacing = UIConstants.contentInset
        
        
        [xStack, commentLabel, dateLabel].forEach({yStack.addArrangedSubview($0)})
        [authorLabel, ratingLabel].forEach({xStack.addArrangedSubview($0)})
//        xStack.setCustomSpacing(UIConstants.xStackSpacing, after: restaurantImage)
    
        let containerView = UIView()
        containerView.addSubview(yStack)
        addSubview(containerView)
        
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2 * UIConstants.contentInset)
        }
        
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray5.cgColor
        containerView.layer.cornerRadius = 10
        
        containerView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2 * UIConstants.contentInset)
        }
    }
    
    private func getStringRating(rating: Double) -> String{
        let fullStar = "★"
        let emptyStar = "☆"

        var roundedRating = Int(rating.rounded())

        var ratingString = ""
        for _ in 1...5 {
            if roundedRating > 0 {
                ratingString += fullStar
                roundedRating -= 1
            } else {
                ratingString += emptyStar
            }
        }

        return ratingString
    }

}
