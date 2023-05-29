//
//  MapViewController.swift
//  BookMyTable
//
//  Created by Evelina on 25.04.2023.
//
import SnapKit
import UIKit
import MapKit
import ClusterKit


class MapViewController: UIViewController {
    
    //MARK: - Private properties
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let xelementSpacing: CGFloat = 4
        static let searchTextFieldHeight: CGFloat = 50
    }
    var reservations: [ReservationData] = [ReservationData(time: "18:10", date: "21 мая", restaurantName: "Branch", restaurantAddress: "Казань, Дзержинского, 6Б", guestsNumber: 2, restaurantImage: UIImage(named: "branch")?.pngData() ?? Data(), status: "Отменено"), ReservationData(time: "21:30", date: "17 апреля", restaurantName: "The Jungle", restaurantAddress: "Казань, ​Спартаковская, 2к1", guestsNumber: 2, restaurantImage: UIImage(named: "jungle")?.pngData() ?? Data(), status: "Завершена")]
    private let mapPresenter = MapPresenter()
    
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
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.setTitle(StringConstants.Main.list, forSegmentAt: 0)
        segmentedControl.setTitle(StringConstants.Main.map, forSegmentAt: 1)
        return segmentedControl
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.clear
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
        
        setupSubview()
        setupConstraints()
        showMap()
    }
    
    private func showMap() {
        tableView.isHidden = true
        mapView.isHidden = false
        searchTextField.isHidden = true
    }
    private func showList() {
        tableView.isHidden = false
        mapView.isHidden = true
        searchTextField.isHidden = false
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
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(mapOrListSegmentedControl.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(44)
        }
        view.bringSubviewToFront(mapOrListSegmentedControl)
        view.bringSubviewToFront(searchTextField)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupMap() {
        let latitude = CLLocationDegrees(55.793698)
        let longitude = CLLocationDegrees(49.125467)
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 10000 / 4
        let coordinateRegion = MKCoordinateRegion(
          center: initialLocation.coordinate,
          latitudinalMeters: regionRadius,
          longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        let algorithm = CKGridBasedAlgorithm()
        mapView.clusterManager.algorithm = algorithm
        let annotations = restaurants.map({
            let location = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            let annotation = MKPointAnnotation()
            annotation.title = $0.title
            annotation.coordinate = location
            return annotation
        })
        mapView.clusterManager.annotations = annotations
        mapView.delegate = self
//        addRestaurantsAnnotation(restaurants: restaurants)
    }
    
    private func addRestaurantsAnnotation(restaurants: [RestaurantData]) {
        restaurants.forEach { restaurant in
            let location = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            let annotation = MKPointAnnotation()
            annotation.title = restaurant.title
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
        }
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
        mapOrListSegmentedControl.addTarget(self, action: #selector(segmentedControlClicked(_:)), for: .valueChanged)
        mapPresenter.getRestaurants(page: num)
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
        let restaurantViewController = RestaurantViewController()
        //часть данных получается по запросу, часть из экрана
        let restaurant = restaurants[indexPath.row]
        restaurantViewController.restaurant = RestaurantDetailData(latitude: restaurant.latitude, longitude: restaurant.longitude, title: restaurant.title, rating: restaurant.rating, cuisine: "", description: "Панорамный ресторан с видом на главную улицу города. Пожалуй, это одно из самых любимых мест не только жителей, но и гостей города! Сытные бизнес-ланчи, разнообразное меню, уютная атмосфера и дружелюбный сервис. А ещё «На крыше» получаются самые красивые фотографии.\n\nКухня\nИтальянская, Мексиканская, Европейская, Гриль, Ближневосточная, Морепродукты, Центральноевропейская.\n\nСредний чек: 1000 — 1500 руб", address: restaurant.address, openingHours: restaurant.openingHours, images: [restaurant.image], like: false, reviews: [
            ReviewData(author: "Альбина", comment: "Отличный ресторан, вкусная кухня, отзывчивый и внимательный персонал, замечательная программа. Посещала различные мероприятия, гастроужины - все супер. Рекомендую", rate: 5, date: "8 марта 2023"),
            ReviewData(author: "Дианара", comment: "Шикарный ресторан. Вкусная кухня,вежливый персонал,атмосфера праздника!)", rate: 5, date: "8 марта 2023"),
            ReviewData(author: "Анастасия", comment: "Не понравилось, что пришлось долго ждать", rate: 4, date: "7 апреля 2023"),
            ReviewData(author: "Татьяна", comment: "Шикарный ресторан. Эстетичное место с приятной музыкой и безупречным обслуживанием. Уровень сервиса просто пробивает потолок. Все продуманно до мелочей. Кухня — выше всяких похвал. Очень внимательные и знающие свое дело официанты и менеджеры", rate: 5, date: "7 марта 2023"),
            ReviewData(author: "Александр", comment: "Заведение огонь! нету аналогов в Казани! фееричные шоу, караоке с хорошим звуком, еда отменная всегда и персонал очень вежливый и приятный!", rate: 5, date: "6 мая 2023"),
            ReviewData(author: "Антон", comment: "Всегда хорошие развлекательные программы,классные ведущие. Еда и напитки отличные,атмосфера огонь!", rate: 5, date: "22 апреля 2023"),
            ReviewData(author: "Дарья", comment: "Были с подругами в данном ресторане в выходные, очень понравилась атмосфера, яркие шоу с танцами в красивых нарядах, с людьми взаимодействует ведущий, интерьер красивый, вкусно готовят, необычные коктейли, кальян дымный и долгий, быстрое обслуживание, хорошее приветливое отношение. Советую к посещению.", rate: 5, date: "6 марта 2023"),
            ReviewData(author: "Гузель", comment: "Мое любимое заведение Казани, кухня отменная, обслуживание на высоком уровне, классные программы и музыка, каждые выходные тут бываем с друзьями, всем рекомендую", rate: 5, date: "5 мая 2023")
        ])
        navigationController?.pushViewController(restaurantViewController, animated: true)
    }
}
// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
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
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.clusterManager.updateClustersIfNeeded()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if ((view.annotation?.isKind(of: CKCluster.self)) != nil) {
            let cluster: CKCluster = view.annotation as! CKCluster
            if (cluster.count > 1) {
                mapView.show(cluster, animated: true)
            }
        } else {
            let restaurantViewController = RestaurantViewController()
            navigationController?.pushViewController(restaurantViewController, animated: true)
        }
    }
}
