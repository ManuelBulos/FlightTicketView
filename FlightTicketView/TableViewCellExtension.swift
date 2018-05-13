//
//  TableViewCellExtension.swift
//
//  Created by Manuel Bulos on 5/9/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import UIKit

extension UITableViewCell {

    func drawDottedLine(start p0: CGPoint, end p1: CGPoint) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [10, 7] // 9 is the length of dash, 7 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

}
