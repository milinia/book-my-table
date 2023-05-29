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
    private var restaurants: [RestaurantData] = [
                                                RestaurantData(latitude: 55.780751, longitude: 49.137154, title: "На крыше", rating: 4.9, address: "Казань, Баумана, 82", openingHours: "12:00 – 01:00", image: UIImage(named: "on_roof")?.pngData() ?? Data()),
                                                 RestaurantData(latitude: 55.790054, longitude: 49.113798, title: "Limoncello", rating: 4.7, address: "Казань, Кави Наджми, 8", openingHours: "8:00 – 02:00", image: UIImage(named: "limoncello")?.pngData() ?? Data()),
                                                 RestaurantData(latitude: 55.821173, longitude: 49.093397, title: "4 кухни", rating: 4.9, address: "Казань, Проспект Ибрагимова, 56", openingHours: "12:00 – 23:00", image: UIImage(named: "4_kitchen")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.795828, longitude: 49.113529, title: "Branch", rating: 4.3, address: "Казань, Дзержинского, 6Б", openingHours: "12:00 – 01:00", image: UIImage(named: "branch")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.794943, longitude: 49.111759, title: "L`Elephant", rating: 3.9, address: "Казань, ​Кремлёвская, 2а", openingHours: "8:00 – 24:00", image: UIImage(named: "slon")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.780897, longitude: 49.127309, title: "The Jungle", rating: 4.6, address: "Казань, ​Спартаковская, 2к1", openingHours: "18:00 – 06:00", image: UIImage(named: "jungle")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.790408, longitude: 49.115936, title: "Хочу и Буду", rating: 4.5, address: "Казань, Баумана, 25", openingHours: "11:00 – 01:00", image: UIImage(named: "hochu_budu")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.78854, longitude: 49.107663, title: "Restobar DALI", rating: 4.0, address: "Казань, ​Московская, 36", openingHours: "12:00 – 23:00", image: UIImage(named: "dali")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.787325, longitude: 49.102668, title: "Хинкальная", rating: 4.2, address: "Казань, Чернышевского, 43", openingHours: "11:00 – 24:00", image: UIImage(named: "hinkalnaya")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.7889, longitude: 49.114292, title: "Истина", rating: 4.5, address: "Казань, Островского, 14", openingHours: "11:00 – 24:00", image: UIImage(named: "istina")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.793627, longitude: 49.137154, title: "LevelL Kitchen&Bar", rating: 4.4, address: "Казань, Кремлёвская, 21", openingHours: "12:00 – 23:00", image: UIImage(named: "level")?.pngData() ?? Data()),
                                                RestaurantData(latitude: 55.793698, longitude: 49.125467, title: "Duran", rating: 4.6, address: "Казань, Пушкина, 46", openingHours: "18:00 – 03:00", image: UIImage(named: "duran")?.pngData() ?? Data())]
    
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
