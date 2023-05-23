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
        static let titleLabelFontSize: CGFloat = 40
        static let xStackSpacing: CGFloat = 8
        static let contentInset: CGFloat = 16
        static let buttonCornerRadius: CGFloat = 20
        static let buttonLabelFontSize: CGFloat = 18
        static let spaceAfterLabels: CGFloat = 6
        static let buttonBorderWidth: CGFloat = 2
        static let spaceAfterTitleLabel: CGFloat = 18
        static let spaceAfterInfoLabel: CGFloat = 36
        static let textFieldWidth: CGFloat = 20
        static let textFieldHeight: CGFloat = 50
    }
    //MARK: - Private UI properties
    private lazy var phoneTextField: UITextField = {
        let textField = CustomTextField()
        textField.text = "+7 "
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        return textField
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.titleLabelFontSize, weight: .bold)
        label.text = StringConstants.authentication + " 👋"
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = StringConstants.Registration.message
        return label
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.registration, for: .normal)
        button.layer.borderWidth = UIConstants.buttonBorderWidth
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.systemGray6.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        return button
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

    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let barButton = UIBarButtonItem(customView: registrationButton)
        navigationItem.rightBarButtonItem = barButton
        
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // TODO: отправка запроса на сервер - проверка что поле заполнено
        let verifyPhoneViewController = VerifyPhoneViewController()
        verifyPhoneViewController.userEnteredPhoneNumber = phoneTextField.text ?? ""
        navigationController?.pushViewController(verifyPhoneViewController, animated: true)
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        phoneTextField.delegate = self
        
        view.addSubview(loginLabel)
        view.addSubview(infoLabel)
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
        
        setupConstraints()
        
//        let backArrowImage = UIImage(systemName: "arrow.left")?.withTintColor(.black)
//        navigationItem.backBarButtonItem?.tintColor = .black
//        navigationItem.backBarButtonItem = UIBarButtonItem(image: backArrowImage, style: .plain, target: nil, action: nil)
    }
    
    private func setupConstraints() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(UIConstants.contentInset + 30)
            make.trailing.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(UIConstants.spaceAfterTitleLabel)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).inset(UIConstants.contentInset)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom).offset(UIConstants.spaceAfterInfoLabel)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset + 20)
        }
        
    }
}

extension AuthenticationViewController: UITextFieldDelegate {
    
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
