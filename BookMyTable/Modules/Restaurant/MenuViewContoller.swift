//
//  MenuViewContoller.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import UIKit


class MenuViewContoller: UIViewController {
    
    //MARK: - Private properties
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let titleLabelFontSize: CGFloat = 15
        static let restaurantViewHeight: CGFloat = 125
    }
    
    var menuImages: [UIImage] = [UIImage(named: "menu")!, UIImage(named: "menu2")!]
    var restaurantImage: Data? = nil
    
    //MARK: - Private UI properties
    
    private lazy var restaurantView: UIImageView = {
        let image = UIImageView()
//        image.layer.cornerRadius = 10
//        image.clipsToBounds = true
//        image.contentMode = .center
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: UIConstants.titleLabelFontSize, weight: .bold)
        label.text = StringConstants.Restaurant.menu
        label.textColor = .white
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        return button
    }()

    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        [restaurantView, menuTableView].forEach({view.addSubview($0)})
        setupSubview()
    }
    
    private func setupSubview() {
        restaurantView.image = darkenImage(image: UIImage(data: restaurantImage ?? Data()) ?? UIImage())
        [menuLabel, backButton].forEach({restaurantView.addSubview($0)})
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: String(describing: MenuTableViewCell.self))
        
        restaurantView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(UIConstants.restaurantViewHeight)
        }
        menuLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(restaurantView.snp.bottom).offset(UIConstants.contentInset)
            make.leading.trailing.bottom.equalToSuperview()
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

extension MenuViewContoller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuTableViewCell.self), for: indexPath)
                        as? MenuTableViewCell else { return MenuTableViewCell()}
        cell.configure(with: menuImages[indexPath.row])
        return cell
    }
}
