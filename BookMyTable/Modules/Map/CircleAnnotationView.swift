//
//  CircleAnnotationView.swift
//  BookMyTable
//
//  Created by Evelina on 28.05.2023.
//

import UIKit
import MapKit

class CircleAnnotationView: MKAnnotationView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        // Adjust the contentMode and size of the image view as needed
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // Customize the appearance of the annotation view's layer
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    override var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
}

