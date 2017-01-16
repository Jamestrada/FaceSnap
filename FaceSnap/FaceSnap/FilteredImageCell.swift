//
//  FilteredImageCell.swift
//  FaceSnap
//
//  Created by James Estrada on 11/01/2017.
//  Copyright © 2017 James Estrada. All rights reserved.
//

import UIKit
import GLKit

class FilteredImageCell: UICollectionViewCell {
    static let reuseIdentifier = String(FilteredImageCell.self)
    
    var eaglContext: EAGLContext!
    var ciContext: CIContext!
    
    lazy var glkView: GLKView = {
       let view = GLKView(frame: self.contentView.frame, context: self.eaglContext)
        view.delegate = self
        return view
    }()
    
    var image: CIImage!
    
    override func layoutSubviews() {
        contentView.addSubview(glkView)
        glkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            glkView.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
            glkView.rightAnchor.constraintEqualToAnchor(contentView.rightAnchor),
            glkView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor),
            glkView.leftAnchor.constraintEqualToAnchor(contentView.leftAnchor)
        ])
    }
}


extension FilteredImageCell: GLKViewDelegate {
    func glkView(view: GLKView, drawInRect rect: CGRect) {
        
        let drawableRectSize = CGSize(width: glkView.drawableWidth, height: glkView.drawableHeight)
        let drawableRect = CGRect(origin: CGPointZero, size: drawableRectSize)
        
        ciContext.drawImage(image, inRect: drawableRect, fromRect: image.extent)
    }
}














