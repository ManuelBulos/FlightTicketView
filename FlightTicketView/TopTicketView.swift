//
//  TopTicketView.swift
//
//  Created by Manuel Bulos on 5/8/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import UIKit

open class TopTicketView: UITableViewCell {
    
    let appearance = TicketViewAppearance.shared()
    var departureCityShortLabel = UILabel()
    var departureCityLongLabel = UILabel()
    var arrivalCityShortLabel = UILabel()
    var arrivalCityLongLabel = UILabel()
    var planeImageView = UIImageView()
    var planeImage: UIImage?
    
    let shapeLayer = CAShapeLayer()
    var circleSize: CGFloat = 6.5
    
    override open func draw(_ rect: CGRect) {
        selectionStyle = .none
        backgroundColor = appearance.cellsBackgroundColor != nil ? appearance.cellsBackgroundColor:appearance.topCellBackgroundColor
        drawTopTicket()
        setElementsPostions()
    }
    
    func setElementsPostions() {
        // departure city short name
        departureCityShortLabel.frame = CGRect(x: frame.width / 10.5, y: frame.height / 6, width: frame.width / 4, height: frame.height / 2)
        departureCityShortLabel.textAlignment = .center
        departureCityShortLabel.font = UIFont.init(name: appearance.cellsBoldFontName, size: frame.height / 2)
        departureCityShortLabel.backgroundColor = appearance.topCellUpperLeftLabelBackgroundColor
        departureCityShortLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(departureCityShortLabel)
        
        // departure city long name
        departureCityLongLabel.frame = CGRect(x: frame.width / 17, y: (frame.height / 6) + (frame.height / 2), width: frame.width / 3, height: frame.height / 4)
        departureCityLongLabel.textAlignment = .center
        departureCityLongLabel.font = UIFont.init(name: appearance.cellsLightFontName, size: frame.height / 4.5)
        departureCityLongLabel.backgroundColor = appearance.topCellBottomLeftLabelBackgroundColor
        departureCityLongLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(departureCityLongLabel)
        
        // arrival city short name
        arrivalCityShortLabel.frame = CGRect(x: frame.width / 1.55 , y: frame.height / 6, width: frame.width / 4, height: frame.height / 2)
        arrivalCityShortLabel.textAlignment = .center
        arrivalCityShortLabel.font = UIFont.init(name: appearance.cellsBoldFontName, size: frame.height / 2)
        arrivalCityShortLabel.backgroundColor = appearance.topCellUpperRightLabelBackgroundColor
        arrivalCityShortLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(arrivalCityShortLabel)
        
        // arrival city long name
        arrivalCityLongLabel.frame = CGRect(x: frame.width / 1.65, y: (frame.height / 6) + (frame.height / 2), width: frame.width / 3, height: frame.height / 4)
        arrivalCityLongLabel.textAlignment = .center
        arrivalCityLongLabel.font = UIFont.init(name: appearance.cellsLightFontName, size: frame.height / 4.5)
        arrivalCityLongLabel.backgroundColor = appearance.topCellBottomRightLabelBackgroundColor
        arrivalCityLongLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(arrivalCityLongLabel)
        
        // plane image
        planeImageView.frame = CGRect(x: frame.width / 2.45, y: 4, width: frame.width / 5.8, height: frame.height)
        if let planeImage = planeImage {
            planeImageView.image = planeImage
        } else {
            planeImageView.image = appearance.planeImage ?? UIImage()
        }
        
        planeImageView.contentMode = appearance.imageContentMode
        self.addSubview(planeImageView)
    }
    
    func drawTopTicket() {
        shapeLayer.removeFromSuperlayer()
        shapeLayer.path = createBezierPath().cgPath
        shapeLayer.strokeColor = appearance.strokeColor.cgColor
        shapeLayer.fillColor = appearance.fillColor.cgColor
        shapeLayer.lineWidth = appearance.lineWidth
        shapeLayer.position = CGPoint(x: 0 , y: 0)
        self.layer.topShadow()
        self.layer.addSublayer(shapeLayer)
    }
    
    func createBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        let startingXPoint: CGFloat = appearance.cellsMargin
        let startingYPoint: CGFloat = frame.height
        let topRightXPoint: CGFloat = frame.width - (frame.height / circleSize) - startingXPoint
        let circleRadius = frame.height / circleSize
        
        path.move(to: CGPoint(x: startingXPoint, y: startingYPoint))
        
        path.addLine(to: CGPoint(x: startingXPoint, y: startingYPoint - circleRadius))
        
        path.addArc(withCenter: CGPoint.init(x: startingXPoint + circleRadius, y: circleRadius),
                    radius: circleRadius,
                    startAngle: CGFloat((180 * Double.pi) / 180),
                    endAngle: CGFloat((270 * Double.pi) / 180),
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: topRightXPoint - circleRadius, y: 0))
        
        path.addArc(withCenter: CGPoint.init(x: topRightXPoint, y: circleRadius),
                    radius: circleRadius,
                    startAngle: CGFloat((270 * Double.pi) / 180),
                    endAngle: CGFloat((360 * Double.pi) / 180),
                    clockwise: true)

        path.addLine(to: CGPoint(x: topRightXPoint + circleRadius, y: startingYPoint))

        return path
    }
}
