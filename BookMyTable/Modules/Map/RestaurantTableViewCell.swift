//
//  RestaurantTableViewCell.swift
//  BookMyTable
//
//  Created by Evelina on 04.05.2023.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    // MARK: - Private constants
    private enum UIConstants {
        static let amountLabelFontSize: CGFloat = 20
        static let xStackSpacing: CGFloat = 8
        static let contentInset: CGFloat = 6
        static let restaurantImageHeight: CGFloat = 90
        static let restaurantImageWidth: CGFloat = 120
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public function
    func configure(with restaurant: RestaurantData) {
        restaurantImage.image = UIImage(data: restaurant.image)
        titleLabel.text = restaurant.title
        addressLabel.text = restaurant.address
        openingLabel.text = restaurant.openingHours
        let mutableAttributedString = ratingLabel.attributedText?.mutableCopy() as! NSMutableAttributedString
        mutableAttributedString.append(NSAttributedString(string: restaurant.rating))
        ratingLabel.attributedText = mutableAttributedString
    }
    
    //MARK: - Private UI properties
    private lazy var restaurantImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.amountLabelFontSize, weight: .bold)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var openingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        let starAttachment = NSTextAttachment(data: nil, ofType: nil)
        starAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(.gray)
        let starString = NSAttributedString(attachment: starAttachment)
        var attributedText = NSMutableAttributedString(attributedString: starString)
        label.attributedText = attributedText
        label.textColor = .systemGray2
        return label
    }()

    // MARK: - Private function
    private func initialize() {
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.distribution = .equalSpacing
        yStack.addArrangedSubview(titleLabel)
        yStack.addArrangedSubview(addressLabel)
        yStack.addArrangedSubview(openingLabel)
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.alignment = .top
        xStack.distribution = .fill
//        yStack.spacing = UIConstants.yStackSpacing
        xStack.addArrangedSubview(restaurantImage)
        restaurantImage.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.restaurantImageHeight)
            make.width.equalTo(UIConstants.restaurantImageWidth)
        }
        xStack.addArrangedSubview(yStack)
        xStack.addArrangedSubview(ratingLabel)
//        xStack.setCustomSpacing(UIConstants.xStackSpacing, after: restaurantImage)
        
        addSubview(xStack)
        xStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
}
