//
//  StartViewController.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    //MARK: - Private properties
    private enum UIConstants {
        static let amountLabelFontSize: CGFloat = 43
        static let buttonLabelFontSize: CGFloat = 18
        static let contentTopInset: CGFloat = 140
        static let contentInset: CGFloat = 16
        static let leadingSpace: CGFloat = 10
        static let contentBottomInset: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 16
    }
    
    //MARK: - Private UI properties
    private lazy var startImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "food2")
        image.alpha = 0.5
        return image
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.Start.button, for: .normal)
        button.backgroundColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.buttonLabelFontSize)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = StringConstants.Start.title
        label.font = .systemFont(ofSize: UIConstants.amountLabelFontSize, weight: .bold)
        return label
    }()
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.addSubview(startImageView)
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        
        setupConstraints()
        nextButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
            //регистрация или ауентификация
    }
    
    private func setupConstraints() {
        startImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentTopInset)
            make.leading.equalToSuperview().inset(UIConstants.leadingSpace)
            make.width.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentBottomInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
}
