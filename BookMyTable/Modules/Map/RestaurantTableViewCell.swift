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
        ratingLabel.text = String(restaurant.rating)
    }
    
    //MARK: - Private UI properties
    private lazy var restaurantImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
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
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var openingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = UIConstants.viewsCornerSize
        return view
    }()
    
    private lazy var starImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemRed
        return image
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    // MARK: - Private function
    private func initialize() {
        ratingView.addSubview(ratingLabel)
        ratingView.addSubview(starImage)
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
            make.centerY.equalToSuperview()
        }
        starImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.contentInset)
            make.leading.equalTo(ratingLabel.snp.trailing).offset(UIConstants.contentInset - 3)
        }
        
        restaurantImage.addSubview(ratingView)
        
        ratingView.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.ratingViewWidth)
            make.height.equalTo(UIConstants.ratingViewHeight)
            make.bottom.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.distribution = .fill
        yStack.spacing = UIConstants.yStackSpacing
        yStack.addArrangedSubview(titleLabel)
        yStack.addArrangedSubview(addressLabel)
        yStack.addArrangedSubview(openingLabel)
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.alignment = .top
        xStack.distribution = .fill
        xStack.addArrangedSubview(restaurantImage)
        restaurantImage.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.restaurantImageHeight)
            make.width.equalTo(UIConstants.restaurantImageWidth)
        }
        xStack.addArrangedSubview(yStack)
        xStack.setCustomSpacing(UIConstants.xStackSpacing, after: restaurantImage)
        
        addSubview(xStack)
        xStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
}
