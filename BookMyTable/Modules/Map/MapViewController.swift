//
//  MapViewController.swift
//  BookMyTable
//
//  Created by Evelina on 25.04.2023.
//
import SnapKit
import UIKit
import MapKit


class MapViewController: UIViewController {
    
    //MARK: - Private properties
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let xelementSpacing: CGFloat = 4
        static let searchTextFieldHeight: CGFloat = 50
    }
    
    private var restaurants: [RestaurantData] = [RestaurantData(latitude: 55.780751, longitude: 49.137154, title: "На крыше", rating: "9.2", address: "Баумана 82", openingHours: "12:00–01:00", image: UIImage(named: "image")?.pngData() ?? Data())]
    
    //MARK: - Private UI properties
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(origin: CGPoint(), size: CGSize()))
        return table
    }()
    
    private lazy var mapOrListSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["0", "1"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.setTitle(StringConstants.Main.list, forSegmentAt: 0)
        segmentedControl.setTitle(StringConstants.Main.map, forSegmentAt: 1)
        return segmentedControl
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect

        
        let magnifyingGlassAttachment = NSTextAttachment(data: nil, ofType: nil)
        magnifyingGlassAttachment.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.systemGray5)
        let magnifyingGlassString = NSAttributedString(attachment: magnifyingGlassAttachment)
        var attributedText = NSMutableAttributedString(attributedString: magnifyingGlassString)
        let searchString = NSAttributedString(string: "  " + StringConstants.Main.search)
        attributedText.append(searchString)
        
        textField.attributedPlaceholder = attributedText
        return textField
    }()
    
    // MARK: - Private methods
    private func setupView() {
        view.addSubview(mapOrListSegmentedControl)
        view.addSubview(searchTextField)
        view.addSubview(mapView)
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        mapOrListSegmentedControl.addTarget(self, action: #selector(segmentedControlClicked(_:)), for: .valueChanged)
        
        setupSubview()
        setupConstraints()
        showMap()
    }
    
    private func showMap() {
        tableView.isHidden = true
        mapView.isHidden = false
    }
    private func showList() {
        tableView.isHidden = false
        mapView.isHidden = true
    }
    
    @objc
    private func segmentedControlClicked(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            showList()
        case 1:
            showMap()
        default:
            break
        }
    }
    
    private func setupSubview() {
        setupMap()
        setupTableView()
    }
    
    private func setupConstraints() {
        mapOrListSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(mapOrListSegmentedControl.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(44)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupMap() {
        let latitude = CLLocationDegrees(55.780751)
        let longitude = CLLocationDegrees(49.137154)
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 10000 / 2
        let coordinateRegion = MKCoordinateRegion(
          center: initialLocation.coordinate,
          latitudinalMeters: regionRadius,
          longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        //добавить аннотации по ресторанам
    }
    
    private func addRestaurantsAnnotation(restaurants: [RestaurantData]) {
        //добавление аннотаций на карту
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: String(describing: RestaurantTableViewCell.self))
    }
    
    // MARK: - UIViewController life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantTableViewCell.self), for: indexPath)
                        as? RestaurantTableViewCell else { return RestaurantTableViewCell()}
        cell.configure(with: restaurants[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //переход к деталке ресторана
    }
}
