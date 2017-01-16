//
//  PhotoCell.swift
//  FaceSnap
//
//  Created by James Estrada on 12/01/2017.
//  Copyright © 2017 James Estrada. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let reuseIdentifier = "\(PhotoCell.self)"
    
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            imageView.leftAnchor.constraintEqualToAnchor(contentView.leftAnchor),
            imageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
            imageView.rightAnchor.constraintEqualToAnchor(contentView.rightAnchor),
            imageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor)
        ])
    }
}
