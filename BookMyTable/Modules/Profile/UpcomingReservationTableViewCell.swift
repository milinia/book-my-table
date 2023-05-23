//
//  UpcomingReservationTableViewCell.swift
//  BookMyTable
//
//  Created by Evelina on 21.05.2023.
//

import UIKit

class UpcomingReservationTableViewCell: UITableViewCell {

    // MARK: - Private constants
    private enum UIConstants {
        static let dateTimeLabel: CGFloat = 25
        static let restaurantTitleLabel: CGFloat = 18
        static let xStackSpacing: CGFloat = 12
        static let contentInset: CGFloat = 6
        static let restaurantImageHeight: CGFloat = 80
        static let restaurantImageWidth: CGFloat = 110
        static let viewsCornerSize: CGFloat = 14
        static let guestsViewWidth: CGFloat = 50
        static let guestsViewHeight: CGFloat = 35
        static let spaceAfterDateTimeLabel: CGFloat = 20
    }
    
    // MARK: - Init
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        applyShadow()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public function
    func configure(with reservation: ReservationData) {
        restaurantImage.image = UIImage(data: reservation.restaurantImage)
        restaurantTitle.text = reservation.restaurantName
        addressLabel.text = reservation.restaurantAddress
        dateAndTimeLabel.text = reservation.date + " в " + reservation.time
        guestsNumberLabel.text = String(reservation.guestsNumber)
    }
    
    //MARK: - Private UI properties
    private lazy var restaurantImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var restaurantTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.restaurantTitleLabel, weight: .bold)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var dateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.dateTimeLabel, weight: .bold)
        return label
    }()
    
    private lazy var guestsNumberView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = UIConstants.viewsCornerSize
        return view
    }()
    
    private lazy var personImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = .black
        return image
    }()
    
    private lazy var guestsNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    // MARK: - Private function
    
    private func applyShadow() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemGray6.cgColor
        layer.cornerRadius = 6
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    private func initialize() {
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.spacing = UIConstants.contentInset + 2
        yStack.alignment = .leading
        yStack.distribution = .fill
        yStack.addArrangedSubview(restaurantTitle)
        yStack.addArrangedSubview(addressLabel)
        yStack.addArrangedSubview(guestsNumberView)
        
        guestsNumberView.addSubview(personImage)
        guestsNumberView.addSubview(guestsNumberLabel)
        
        personImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        guestsNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.contentInset)
            make.leading.equalTo(personImage.snp.trailing).offset(UIConstants.contentInset)
        }
        
        guestsNumberView.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.guestsViewWidth)
            make.height.equalTo(UIConstants.guestsViewHeight)
        }
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.alignment = .top
//        xStack.distribution = .equalSpacing
//        yStack.spacing = UIConstants.yStackSpacing
        xStack.addArrangedSubview(restaurantImage)
        restaurantImage.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.restaurantImageHeight)
            make.width.equalTo(UIConstants.restaurantImageWidth)
        }
        xStack.addArrangedSubview(yStack)
        yStack.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        xStack.setCustomSpacing(UIConstants.xStackSpacing, after: restaurantImage)
        
        addSubview(dateAndTimeLabel)
        addSubview(xStack)
        dateAndTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        xStack.snp.makeConstraints { make in
            make.top.equalTo(dateAndTimeLabel.snp.bottom).offset(UIConstants.spaceAfterDateTimeLabel)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalToSuperview().inset(UIConstants.contentInset)
        }
    }

}
