//
//  AuthenticationViewController.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import UIKit

class AuthenticationViewController: UIViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let amountLabelFontSize: CGFloat = 20
        static let xStackSpacing: CGFloat = 8
        static let contentInset: CGFloat = 6
        static let restaurantImageHeight: CGFloat = 90
        static let restaurantImageWidth: CGFloat = 120
    }
    //MARK: - Private UI properties
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.amountLabelFontSize, weight: .bold)
        label.text = StringConstants.Registration.phoneNumber
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.text = StringConstants.Registration.PhoneNumber.message
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
