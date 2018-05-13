//
//  BottomTicketView.swift
//
//  Created by Manuel Bulos on 5/8/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import UIKit

open class BottomTicketView: UITableViewCell {
    
    let appearance = TicketViewAppearance.shared()
    
    var airlineLogoImageView = UIImageView()
    var label = UILabel()
    
    var airlineLogo = UIImage()
    var departureTime = String()
    var departureCity = String()
    var arrivalTime = String()
    var arrivalCity = String()
    var airlineName = String()
    
    let shapeLayer = CAShapeLayer()
    var circleSize: CGFloat = 6.5

    override open func draw(_ rect: CGRect) {
        selectionStyle = .none
        circleSize = appearance.circleInvertedRadius
        backgroundColor = appearance.cellsBackgroundColor != nil ? appearance.cellsBackgroundColor:appearance.bottomCellBackgroundColor
        drawBottomTicket()
        drawDottedLine(start: CGPoint.init(x: appearance.cellsMargin + 10 + (frame.height / circleSize), y: 1),
                       end: CGPoint.init(x: (frame.width - (frame.height / circleSize)) - 10 - appearance.cellsMargin, y: 1))
        setElementsPostions()
    }
    
    func setElementsPostions() {
        let elementsMargin: CGFloat = 8
        let circleRadius = (frame.height / circleSize)
        let topTextFontSize: CGFloat = frame.width / (frame.height / (elementsMargin - 2.8))
        let BottomTextFontSize: CGFloat = frame.width / (frame.height / (elementsMargin - 3.8))
        
        // airline logo
        let logoXCoordinate: CGFloat = appearance.cellsMargin + circleRadius + elementsMargin
        let logoYCoordinate: CGFloat = circleRadius * 1.5
        let logoWidth: CGFloat = (frame.width / 4) - appearance.cellsMargin - elementsMargin
        let logoHeight: CGFloat = frame.height - (circleRadius * 3)
        
        airlineLogoImageView.frame = CGRect(x: logoXCoordinate, y: logoYCoordinate, width: logoWidth, height: logoHeight)
        airlineLogoImageView.contentMode = appearance.imageContentMode
        airlineLogoImageView.image = airlineLogo
        self.addSubview(airlineLogoImageView)
        
        // fligh time and airline info
        let xCoordinate: CGFloat = logoXCoordinate + logoWidth + elementsMargin + appearance.cellsMargin
        let yCoordinate: CGFloat = circleRadius / 2.5
        let width: CGFloat = frame.width - logoXCoordinate - logoWidth - circleRadius - appearance.cellsMargin - elementsMargin
        let height: CGFloat = frame.height - circleRadius
        
        label.frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        
        let text = NSMutableAttributedString(string: "\(departureTime) - \(arrivalTime) \(appearance.flightHoursAdditionalText)\n\(departureCity.shortenName())-\(arrivalCity.shortenName()), \(airlineName)")
        
        let topTextCount = departureTime.count + arrivalTime.count + appearance.flightHoursAdditionalText.count + 4
        let bottomTextCount = departureCity.shortenName().count + arrivalCity.shortenName().count + airlineName.count + 3 + 1
        
        text.setAttributes([NSAttributedStringKey.font:(UIFont(name: appearance.cellsBoldFontName, size: topTextFontSize)) ?? UIFont()], range: NSMakeRange(0, topTextCount))
        text.setAttributes([NSAttributedStringKey.font:(UIFont(name: appearance.cellsLightFontName, size: BottomTextFontSize)) ?? UIFont()], range: NSMakeRange(topTextCount,bottomTextCount))
        label.attributedText = text
        
        self.addSubview(label)
    }
    
    func drawBottomTicket() {
        shapeLayer.removeFromSuperlayer()
        shapeLayer.path = createBezierPath().cgPath
        shapeLayer.strokeColor = appearance.strokeColor.cgColor
        shapeLayer.fillColor = appearance.fillColor.cgColor
        shapeLayer.lineWidth = appearance.lineWidth
        shapeLayer.position = CGPoint(x: 0 , y: 0)
        self.layer.dropShadow()
        self.layer.addSublayer(shapeLayer)
    }
    
    func createBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        let startingXPoint: CGFloat = appearance.cellsMargin
        let startingYPoint: CGFloat = frame.height
        let topRightXPoint: CGFloat = frame.width - startingXPoint
        let circleRadius = frame.height / circleSize
        
        path.move(to: CGPoint(x: startingXPoint, y: startingYPoint - circleRadius))
        
        path.addLine(to: CGPoint(x: startingXPoint, y: 0))
        
        path.move(to: CGPoint(x: topRightXPoint, y: 0))
        
        path.addLine(to: CGPoint(x: topRightXPoint, y: startingYPoint  - circleRadius))
        
        path.addArc(withCenter: CGPoint.init(x: topRightXPoint - circleRadius, y: startingYPoint  - circleRadius),
                    radius: circleRadius,
                    startAngle: CGFloat((360 * Double.pi) / 180),
                    endAngle: CGFloat((90 * Double.pi) / 180),
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: startingXPoint + circleRadius, y: startingYPoint))
        
        path.addArc(withCenter: CGPoint.init(x: startingXPoint + circleRadius, y: startingYPoint  - circleRadius),
                    radius: circleRadius,
                    startAngle: CGFloat((90 * Double.pi) / 180),
                    endAngle: CGFloat((180 * Double.pi) / 180),
                    clockwise: true)
        
        return path
    }
}
