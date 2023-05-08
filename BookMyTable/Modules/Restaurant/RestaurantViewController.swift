//
//  RestaurantViewController.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    //MARK: - Private properties
    private enum UIConstants {
        static let amountLabelFontSize: CGFloat = 20
        static let contentInset: CGFloat = 16
        static let xelementSpacing: CGFloat = 4
        static let searchTextFieldHeight: CGFloat = 50
    }
    
    //MARK: - Private UI properties
    private lazy var restaurantView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var likedButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var photoButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var reviewButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.amountLabelFontSize, weight: .bold)
        return label
    }()
    
    private lazy var openingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
    }()
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private methods
    private func setupView() {
       
    }
}
