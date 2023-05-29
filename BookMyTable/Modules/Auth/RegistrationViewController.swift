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
        static let titleLabelFontSize: CGFloat = 40
        static let xStackSpacing: CGFloat = 8
        static let contentInset: CGFloat = 16
        static let textFieldWidth: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 20
        static let buttonLabelFontSize: CGFloat = 18
        static let spaceAfterTitleLabel: CGFloat = 18
        static let spaceAfterInfoLabel: CGFloat = 36
        static let buttonBorderWidth: CGFloat = 2
        static let textFieldHeight: CGFloat = 50
        static let bottomtConstaint: CGFloat = 24
        static let agreementLabeFontSize: CGFloat = 14
        static let topSpace: CGFloat = 60
    }
    private var phoneNumberString: String = ""
    //MARK: - Private UI properties
    private lazy var nameTextField: UITextField = {
        let textField = CustomTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
//        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.placeholder = StringConstants.Registration.name
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = CustomTextField()
        textField.text = "+7 9"
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        return textField
    }()
    
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.titleLabelFontSize, weight: .bold)
        label.text = StringConstants.registration + " ✍️"
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = StringConstants.Registration.info
        return label
    }()
    
    private lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: UIConstants.agreementLabeFontSize, weight: .regular)
        label.text = StringConstants.Registration.agreement
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.Registration.next, for: .normal)
        button.backgroundColor = UIColor(red: 0.07, green: 0.29, blue: 0.71, alpha: 0.82)
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.buttonLabelFontSize)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.Registration.login, for: .normal)
        button.layer.borderWidth = UIConstants.buttonBorderWidth
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.systemGray6.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        return button
    }()

    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let barButton = UIBarButtonItem(customView: loginButton)
        navigationItem.rightBarButtonItem = barButton
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let authViewController = AuthenticationViewController()
        navigationController?.pushViewController(authViewController, animated: true)
    }
    
    @objc func nextButtonTapped() {
        // TODO: отправка запроса на сервер - проверка, что все поля заполнены
        if (nameTextField.text == "") {
            nameTextField.layer.borderColor = UIColor.systemRed.cgColor
            nameTextField.layer.borderWidth = 1.0
        } else if (phoneTextField.text == "+7 9" && phoneTextField.text?.count != 16) {
            phoneTextField.layer.borderColor = UIColor.systemRed.cgColor
            phoneTextField.layer.borderWidth = 1.0
        } else {
            let verifyPhoneViewController = VerifyPhoneViewController()
            verifyPhoneViewController.userEnteredPhoneNumber = phoneTextField.text ?? ""
            navigationController?.pushViewController(verifyPhoneViewController, animated: true)
        }
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        phoneTextField.delegate = self
        nameTextField.delegate = self
        
        view.addSubview(registrationLabel)
        view.addSubview(infoLabel)
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        view.addSubview(agreementLabel)
        view.addSubview(nextButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        registrationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(UIConstants.topSpace)
            make.trailing.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(registrationLabel.snp.bottom).offset(UIConstants.spaceAfterTitleLabel)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).inset(UIConstants.contentInset)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom).offset(UIConstants.spaceAfterInfoLabel)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTextField.snp.bottom).offset(UIConstants.spaceAfterInfoLabel)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        
        agreementLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.topMargin).inset(-UIConstants.contentInset - 20)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset + 30)
//            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset + 20)
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == phoneTextField) {
            let allowedCharacters = "1234567890"
            let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharcterSet = CharacterSet(charactersIn: string)
            
           formatPhoneNumber(textField: textField)
            if (textField.text?.count ?? 0 <= 15 && textField.text?.count ?? 0 >= 3 && typedCharcterSet.isSubset(of: allowedCharcterSet)) {
                return true
            }
            return false
        } else {
            return true
        }
    }
    
    private func formatPhoneNumber(textField: UITextField) {
        var currentText = textField.text ?? ""
        
        if currentText.count == 6 {
            currentText.insert(" ", at: currentText.index(currentText.startIndex, offsetBy: 6))
        }
        if currentText.count == 10 {
            currentText.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 10))
        }
        if currentText.count == 13 {
            currentText.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 13))
        }
        
        textField.text = currentText
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 1.0
      }

      func textFieldDidEndEditing(_ textField: UITextField) {
          textField.layer.borderColor = UIColor.systemGray5.cgColor
          textField.layer.borderWidth = 0.5
      }


}

