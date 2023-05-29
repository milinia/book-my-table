//
//  ReservationDetailViewController.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import UIKit
import Lottie
import SnapKit

class ReservationDetailViewController: UIViewController {
    //MARK: - Private properties
    private enum UIConstants {
        static let restaurantTitleLabel: CGFloat = 35
        static let contentInset: CGFloat = 16
        static let xelementSpacing: CGFloat = 4
        static let searchTextFieldHeight: CGFloat = 50
        static let buttonCornerRadius: CGFloat = 20
        static let smallButtonCornerRadius: CGFloat = 10
        static let buttonLabelFontSize: CGFloat = 18
        static let restaurantViewHeight: CGFloat = 200
        static let viewsCornerSize: CGFloat = 14
        static let scrollViewHeight: CGFloat = 1000
        static let spaceAfterTitleLabel: CGFloat = 10
        static let ratingViewWidth: CGFloat = 80
        static let addressViewHeight: CGFloat = 100
        static let infoViewHeight: CGFloat = 200
        static let labelsFontSize: CGFloat = 18
        static let statusLabelFontSize: CGFloat = 14
        static let infoLabelInset: CGFloat = 20
    }
    private var animationView: LottieAnimationView?
    var reservationData: ReservationData? = nil
    
    //MARK: - Private UI properties
    private lazy var restaurantView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.restaurantTitleLabel, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = UIConstants.viewsCornerSize
        return view
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = UIConstants.smallButtonCornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.Detail.status + ":"
        return label
    }()
    
    private lazy var statusDataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: UIConstants.statusLabelFontSize, weight: .bold)
        label.text = StringConstants.Reservation.Detail.status + ":"
        return label
    }()
    
    private lazy var dateDataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.date + ":"
        return label
    }()
    
    private lazy var timeDataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.time + ":"
        return label
    }()
    
    private lazy var guestsDataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    private lazy var guestsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.guests + ":"
        return label
    }()
    
    private lazy var addressDataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
//        label.textAlignment = .center
        return label
    }()
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.Detail.address + ":"
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.Reservation.Detail.cancel, for: .normal)
        button.backgroundColor = .systemRed
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.buttonLabelFontSize)
        return button
    }()
    
    private lazy var reviewButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.Reservation.Detail.review, for: .normal)
        button.backgroundColor = UIColor(red: 0.07, green: 0.29, blue: 0.71, alpha: 0.82)
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.buttonLabelFontSize)
        return button
    }()
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        
        [restaurantView, infoView, cancelButton, reviewButton].forEach({contentView.addSubview($0)})
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
        
        setupSubview()
        setupConstraints()
    }
    
    private func setupSubview() {
        cancelButton.isHidden = true
        reviewButton.isHidden = true
        [titleLabel, backButton].forEach({restaurantView.addSubview($0)})
        [dateLabel, timeLabel, guestsLabel, addressLabel, statusLabel].forEach({infoView.addSubview($0)})
        [dateDataLabel, timeDataLabel, guestsDataLabel, addressDataLabel, statusView].forEach({infoView.addSubview($0)})
        statusView.addSubview(statusDataLabel)
        configure()
    }
    
    private func configure() {
        restaurantView.image = darkenImage(image: UIImage(data: reservationData?.restaurantImage ?? Data()) ?? UIImage())
        titleLabel.text = reservationData?.restaurantName
        dateDataLabel.text = reservationData?.date
        timeDataLabel.text = reservationData?.time
        guestsDataLabel.text = String(reservationData!.guestsNumber)
        addressDataLabel.text = reservationData?.restaurantAddress
        statusDataLabel.text = reservationData?.status
        statusDataLabel.textColor = getStatusColor(status: reservationData?.status ?? "")
        if (reservationData?.status == ReservationStatus.process.rawValue) {
            cancelButton.isHidden = false
        }
        if (reservationData?.status == ReservationStatus.done.rawValue) {
            reviewButton.isHidden = false
        }
    }
    
    private func getStatusColor(status: String) -> UIColor {
        switch status {
        case ReservationStatus.cancel.rawValue: return UIColor.systemRed
        case ReservationStatus.done.rawValue: return UIColor.black
        case ReservationStatus.process.rawValue: return UIColor.systemGreen
        default: return UIColor.black
        }
    }
    
    private func setupConstraints() {
        restaurantView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(UIConstants.restaurantViewHeight)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(1.5 * UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(restaurantView.snp.bottom).offset(UIConstants.contentInset + 10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.bounds.width - 2 * UIConstants.contentInset)
            make.height.equalTo(UIConstants.infoViewHeight)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(UIConstants.contentInset + 10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset + 20)
        }
        
        reviewButton.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(UIConstants.contentInset + 10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset + 20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        dateDataLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.equalTo(guestsLabel.snp.trailing).offset(UIConstants.infoLabelInset)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        timeDataLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalTo(guestsLabel.snp.trailing).offset(UIConstants.infoLabelInset)
        }
        
        guestsLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        guestsDataLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalTo(guestsLabel.snp.trailing).offset(UIConstants.infoLabelInset)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        addressDataLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalTo(addressLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(guestsLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        statusView.snp.makeConstraints { make in
            make.top.equalTo(guestsLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalTo(guestsLabel.snp.trailing).offset(UIConstants.contentInset)
            make.width.equalTo(95)
            make.height.equalTo(30)
        }
        statusDataLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
    }

    private func darkenImage(image: UIImage) -> UIImage? {
        let overlayColor = UIColor(white: 0, alpha: 0.5)

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        image.draw(at: CGPoint.zero)

        context?.setFillColor(overlayColor.cgColor)
        context?.setBlendMode(.multiply)
        context?.fill(CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))

        let darkenedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return darkenedImage
    }

    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        contentView.isHidden = true
//        setupAnimation()
        setupView()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func backButtonTapped() {
        if (navigationController?.viewControllers[(navigationController?.viewControllers.count ?? 2) - 2] is ReservationViewController) {
            guard let viewControllers = navigationController?.viewControllers else {return}
            guard let destinationViewController = viewControllers[viewControllers.count - 4] as? TabBarController else {return}
            guard let reservationVC = destinationViewController.viewControllers?[2] as? HistoryReservationViewController else {return}
            reservationVC.reservations.insert(ReservationData(time: timeDataLabel.text!, date: dateDataLabel.text!, restaurantName: titleLabel.text!, restaurantAddress: addressDataLabel.text!, guestsNumber: Int(guestsDataLabel.text ?? "1") ?? 1, restaurantImage: UIImage(named: "on_roof")?.pngData() ?? Data(), status: "Ожидается"), at: 0)
            reservationVC.updateTable()
            destinationViewController.selectedIndex = 2
            navigationController?.popToViewController(destinationViewController, animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func setupAnimation() {
        animationView = .init(name: "92541-loading")
        animationView?.frame = CGRect(origin: CGPoint(), size: CGSize(width: view.bounds.width / 2, height: view.bounds.height / 2))
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.8
        view.addSubview(animationView!)
        animationView?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(view.bounds.width / 2)
            make.height.equalTo(view.bounds.height / 2)
        })
        animationView?.play()
        stopAnimation()
    }
    
    private func stopAnimation() {
        animationView?.stop()
        contentView.isHidden = false
        animationView?.isHidden = true
    }
}
