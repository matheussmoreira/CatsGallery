//
//  ImageCell.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupShadowEffect()
        layer.cornerRadius = 10.0
        layer.shouldRasterize = true
        clipsToBounds = true
        
        setupImage()
    }
    
    private func setupShadowEffect() {
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 10.0
        layer.shadowOffset = .zero
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    private func setupImage(){
        let padding: CGFloat = 7.5
        
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // layoutSubviews ???
}
