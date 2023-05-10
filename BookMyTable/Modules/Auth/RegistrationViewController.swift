//
//  ViewController.swift
//  BookMyTable
//
//  Created by Evelina on 21.02.2023.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Private constants
    private enum UIConstants {
        static let amountLabelFontSize: CGFloat = 20
        static let xStackSpacing: CGFloat = 8
        static let contentInset: CGFloat = 6
        static let restaurantImageHeight: CGFloat = 90
        static let restaurantImageWidth: CGFloat = 120
    }
    //MARK: - Private UI properties
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.amountLabelFontSize, weight: .bold)
        label.text = StringConstants.registration
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.amountLabelFontSize, weight: .bold)
        label.text = StringConstants.Registration.phoneNumber
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

