//
//  TimeCollectionViewCell.swift
//  BookMyTable
//
//  Created by Evelina on 17.05.2023.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public function
    func configure(with time: String) {
        timeLabel.text = time
    }
    
    //MARK: - Private UI properties
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    // MARK: - Private function
    private func initialize() {
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 0.07, green: 0.29, blue: 0.71, alpha: 0.82).cgColor
        layer.cornerRadius = 10
    }
    
}
