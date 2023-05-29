//
//  MenuTableViewCell.swift
//  BookMyTable
//
//  Created by Evelina on 28.05.2023.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 6
//        static let menuImageWidth: CGFloat = 100
//        static let menuImageHeight: CGFloat = 300
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public function
    func configure(with image: UIImage) {
        menuImage.image = image
    }
    
    //MARK: - Private UI properties
    private lazy var menuImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    // MARK: - Private function
    private func initialize() {
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.alignment = .center
        
        yStack.addArrangedSubview(menuImage)
        
        menuImage.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 25)
            make.height.equalTo(UIScreen.main.bounds.height - 325)
        }
       
        addSubview(yStack)
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
