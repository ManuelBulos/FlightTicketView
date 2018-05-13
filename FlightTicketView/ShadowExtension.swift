//
//  ShadowExtension.swift
//
//  Created by Manuel Bulos on 5/8/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    func topShadow(color: UIColor = .black, opacity: Float = 0.15, radius: CGFloat = 5, scale: Bool = true) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowOffset = CGSize.zero
        shadowRadius = radius
        
        shouldRasterize = true
        shadowPath = UIBezierPath(roundedRect: CGRect.init(x: 2, y: 2, width: self.frame.width - 4, height: self.frame.height / 1.5), cornerRadius: self.frame.height / 2).cgPath
        rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color: UIColor = .black, opacity: Float = 0.15, radius: CGFloat = 5, scale: Bool = true) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowOffset = CGSize.zero
        shadowRadius = radius
        
        shouldRasterize = true
        shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.frame.height / 2).cgPath
        rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
