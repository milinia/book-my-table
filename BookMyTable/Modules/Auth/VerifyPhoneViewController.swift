//
//  VerifyPhoneViewController.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import UIKit

class VerifyPhoneViewController: UIViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let titleLabelFontSize: CGFloat = 35
        static let xStackSpacing: CGFloat = 12
        static let contentInset: CGFloat = 16
        static let spaceAfterTitleLabel: CGFloat = 18
        static let spaceAfterInfoLabel: CGFloat = 36
        static let buttonCornerRadius: CGFloat = 20
        static let buttonLabelFontSize: CGFloat = 18
        static let sentAgainButtonFontSize: CGFloat = 16
        static let textFieldWidthInsets: CGFloat = 20
        static let textFieldHeightInsets: CGFloat = 50
    }
    
    var userEnteredPhoneNumber: String = ""
    
    //MARK: - Private UI properties
    private lazy var firstTextField: UITextField = {
        let textField = CustomTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        return textField
    }()
    
    private lazy var secondTextField: UITextField = {
        let textField = CustomTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        return textField
    }()
    
    private lazy var thirdTextField: UITextField = {
        let textField = CustomTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        return textField
    }()
    
    private lazy var fouthTextField: UITextField = {
        let textField = CustomTextField()
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: UIConstants.titleLabelFontSize, weight: .bold)
        label.text = StringConstants.verify + " ☎️"
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.text = StringConstants.Verify.message + " " + userEnteredPhoneNumber
        return label
    }()
    
    private lazy var xStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = UIConstants.xStackSpacing
        return stack
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.Verify.button, for: .normal)
        button.backgroundColor = UIColor(red: 0.07, green: 0.29, blue: 0.71, alpha: 0.82)
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.buttonLabelFontSize)
        return button
    }()
    
    private lazy var sentAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringConstants.Verify.again, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.sentAgainButtonFontSize)
        return button
    }()

    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        fouthTextField.delegate = self
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // TODO: отправка запроса на сервер - проверка что поле заполнено
        
        // Get the current window
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        // Create a new view controller to set as the root view controller
        let tabBarViewController = UITabBarController()
        let recVC = RecommendationViewController()
        recVC.title = StringConstants.TabBar.feed
        let mapVC = MapViewController()
        mapVC.title = StringConstants.TabBar.search
        let profileVC = ProfileViewController()
        profileVC.title = StringConstants.TabBar.reservations
        tabBarViewController.setViewControllers([recVC, mapVC, profileVC], animated: false)
        tabBarViewController.tabBar.backgroundColor = .systemGray5
        let items = tabBarViewController.tabBar.items
        let images = [UIImage(systemName: "house"), UIImage(systemName: "magnifyingglass"), UIImage(systemName: "list.clipboard")]
        for i in 0...2 {
            items?[i].image = images[i]
        }
        tabBarViewController.selectedIndex = 0

        // Set the root view controller to the new view controller
        window.rootViewController = tabBarViewController

    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        
        xStack.addArrangedSubview(firstTextField)
        xStack.addArrangedSubview(secondTextField)
        xStack.addArrangedSubview(thirdTextField)
        xStack.addArrangedSubview(fouthTextField)
        
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(xStack)
        view.addSubview(sentAgainButton)
        view.addSubview(nextButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(UIConstants.contentInset + 30)
            make.trailing.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIConstants.spaceAfterTitleLabel)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).inset(UIConstants.contentInset)
        }
        
        xStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom).offset(UIConstants.spaceAfterInfoLabel)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidthInsets + 30)
            make.height.equalTo(UIConstants.textFieldHeightInsets)
        }
        
        sentAgainButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(xStack.snp.bottom).offset(UIConstants.spaceAfterInfoLabel)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset + 20)
        }
    }
}

extension VerifyPhoneViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.count == 0 && string != "") {
            textField.text = string
            switch textField {
            case self.firstTextField:
                self.secondTextField.becomeFirstResponder()
            case self.secondTextField:
                self.thirdTextField.becomeFirstResponder()
            case self.thirdTextField:
                self.fouthTextField.becomeFirstResponder()
            case self.fouthTextField:
                self.fouthTextField.resignFirstResponder()
            default:
                break
            }
            return true
        } else if (textField.text?.count == 1 && string != "") {
            return false
        }

        return true
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
