//
//  RestaurantViewController.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import UIKit
import MapKit
import SnapKit

class RestaurantViewController: UIViewController {
    
    //MARK: - Private properties
    private enum UIConstants {
        static let labelsFontSize: CGFloat = 22
        static let restaurantTitleLabel: CGFloat = 35
        static let contentInset: CGFloat = 16
        static let xelementSpacing: CGFloat = 4
        static let searchTextFieldHeight: CGFloat = 50
        static let buttonCornerRadius: CGFloat = 20
        static let smallButtonCornerRadius: CGFloat = 10
        static let buttonLabelFontSize: CGFloat = 18
        static let restaurantViewHeight: CGFloat = 300
        static let viewsCornerSize: CGFloat = 14
        static let scrollViewHeight: CGFloat = 1120
        static let spaceAfterTitleLabel: CGFloat = 10
        static let ratingViewWidth: CGFloat = 80
        static let addressViewHeight: CGFloat = 200
        static let mapViewWidth: CGFloat = 250
    }
    
    var restaurant: RestaurantDetailData? = nil
    private var previousContentOffset: CGFloat = 0
    
    //MARK: - Private UI properties
    private lazy var restaurantView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var likedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.circle"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringConstants.Restaurant.menu, for: .normal)
        button.backgroundColor = .gray
        button.tintColor = .white
        button.layer.cornerRadius = UIConstants.smallButtonCornerRadius
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = UIConstants.smallButtonCornerRadius
        view.isUserInteractionEnabled = true
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.restaurantTitleLabel, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var infoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18, weight: .regular)
        textView.isUserInteractionEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Restaurant.description
        return label
    }()
    
    private lazy var openingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "ПН-ВС"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private lazy var openingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Restaurant.time
        return label
    }()
    private lazy var openingView: UIView = {
        let view = UIView()
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    private lazy var timeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    
    
    private lazy var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Restaurant.address
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var addressView: UIView = {
        let view = UIView()
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    private lazy var reserveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.Reservation.button, for: .normal)
        button.backgroundColor = UIColor(red: 0.24, green: 0.42, blue: 0.76, alpha: 1.00)
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.buttonLabelFontSize)
        return button
    }()
    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
//        collection.showsVerticalScrollIndicator = false
//        return collection
//    }()
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect())
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: UIConstants.scrollViewHeight)
        return scrollView
    }()
    
    private lazy var showAllCommentsButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringConstants.Restaurant.show, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return button
    }()
    
    private lazy var reviewCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Restaurant.reviews
        return label
    }()
    
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        reserveButton.addTarget(self, action: #selector(reserveButtonTapped), for: .touchUpInside)
        showAllCommentsButton.addTarget(self, action: #selector(reviewUIViewTapped), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reviewUIViewTapped))
        ratingView.addGestureRecognizer(tapGesture)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func reviewUIViewTapped() {
        let reviewViewController = ReviewViewController()
        reviewViewController.restaurantImage = restaurant?.images.first
        reviewViewController.reviews = restaurant?.reviews ?? []
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    @objc func menuButtonTapped() {
        let menuViewController = MenuViewContoller()
        menuViewController.restaurantImage = restaurant?.images.first
        navigationController?.pushViewController(menuViewController, animated: true)
    }
    
    @objc func reserveButtonTapped() {
        let reservationViewController = ReservationViewController()
        reservationViewController.restaurantTitle = restaurant?.title ?? ""
        reservationViewController.restaurantAddress = restaurant?.address ?? ""
        reservationViewController.restaurantImage = restaurant?.images.first ?? Data()
        navigationController?.pushViewController(reservationViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        
        [restaurantView, scrollView].forEach({view.addSubview($0)})
        setupSubview()
        setupConstraints()
    }
    
    private func setupSubview() {
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
        reviewCollection.register(HorizontalReviewCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HorizontalReviewCollectionViewCell.self))
        scrollView.delegate = self
//        mapView.delegate = self
        
        [backButton, titleLabel, likedButton, menuButton, ratingView].forEach({restaurantView.addSubview($0)})
        [ratingLabel, starImage].forEach({ratingView.addSubview($0)})
        [addressTitleLabel, addressLabel, mapView].forEach({addressView.addSubview($0)})
        [timeLabel, openingLabel].forEach({timeView.addSubview($0)})
        [openingTitleLabel, timeView].forEach({openingView.addSubview($0)})
        [reviewCollection, reviewTitleLabel, showAllCommentsButton, reserveButton, addressView, openingView, infoTitleLabel, infoTextView].forEach({scrollView.addSubview($0)})
        scrollView.bringSubviewToFront(reserveButton)
        
        configure()
    }
    
    private func configure() {
        restaurantView.image = darkenImage(image: UIImage(data: restaurant?.images.first ?? Data()) ?? UIImage())
        titleLabel.text = restaurant?.title
        ratingLabel.text = String(restaurant!.rating)
        addressLabel.text = restaurant?.address
        openingLabel.text = restaurant?.openingHours
        infoTextView.text = restaurant?.description
        
        let location = CLLocationCoordinate2D(latitude: restaurant?.latitude ?? 0, longitude: restaurant?.longitude ?? 0)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
    private func setupConstraints() {
        restaurantView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(UIConstants.restaurantViewHeight)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(restaurantView.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
//            make.width.equalTo(60)
//            make.height.equalTo(60)
        }
        likedButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(6 * UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        menuButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIConstants.spaceAfterTitleLabel)
            make.leading.equalTo(ratingView.snp.trailing).offset(UIConstants.contentInset)
        }
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIConstants.spaceAfterTitleLabel)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
            make.width.equalTo(UIConstants.ratingViewWidth)
            make.height.equalTo(menuButton.snp.height)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
            make.centerY.equalToSuperview()
        }
        starImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(ratingLabel.snp.trailing).offset(3)
        }
        
        reserveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset + 20)
        }
        
        infoTextView.snp.makeConstraints { make in
            make.top.equalTo(infoTitleLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
            make.height.equalTo(375)
            make.width.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        infoTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        addressView.snp.makeConstraints { make in
            make.top.equalTo(openingView.snp.bottom).offset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(UIConstants.addressViewHeight)
        }
        
        addressTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(addressTitleLabel.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(120)
//            make.bottom.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        openingView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(reviewCollection.snp.bottom).offset(UIConstants.contentInset)
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(150)
        }
        openingTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        timeView.snp.makeConstraints { make in
            make.top.equalTo(openingTitleLabel.snp.bottom).offset(1.5 * UIConstants.contentInset)
            make.leading.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(85)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
        }
        openingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(UIConstants.contentInset)
        }
        reviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoTextView.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        showAllCommentsButton.snp.makeConstraints { make in
            make.top.equalTo(infoTextView.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalTo(reviewTitleLabel.snp.trailing).offset(11 * UIConstants.contentInset)
        }
        reviewCollection.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.bottom).offset(UIConstants.contentInset)
            make.height.equalTo(240)
            make.width.equalToSuperview()
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

}

extension RestaurantViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentContentOffset = scrollView.contentOffset.y

        if currentContentOffset > previousContentOffset { // Scrolling down
            hideButton()
        }
//        else if currentContentOffset < previousContentOffset {  // Scrolling up
//            showButton()
//        }

        previousContentOffset = currentContentOffset
    }

    private func hideButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.reserveButton.frame.origin.y -= 50
        })
    }

    private func showButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.reserveButton.frame.origin.y += 50
        })
    }
}

//extension RestaurantViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {return nil}
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
//
//        if annotationView == nil {
//                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom") //Create View
//        } else {
//                annotationView?.annotation = annotation  //Assign annotation
//        }
//        annotationView?.image = UIImage(named: "pin2")
//        return annotationView
//    }
//}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height

        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Set the desired spacing between columns
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Set the desired spacing between rows
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HorizontalReviewCollectionViewCell.self), for: indexPath) as? HorizontalReviewCollectionViewCell else { return HorizontalReviewCollectionViewCell()}
        cell.configure(with: (restaurant?.reviews[indexPath.row])!)
        return cell
    }
}
