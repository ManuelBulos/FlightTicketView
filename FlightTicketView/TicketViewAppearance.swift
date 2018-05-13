//
//  TicketViewAppearance.swift
//
//  Created by Manuel Bulos on 5/9/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import UIKit
import Foundation

open class TicketViewAppearance {
    
    static var sharedTicketViewAppearance: TicketViewAppearance = {
        return TicketViewAppearance()
    }()
    
    open class func shared() -> TicketViewAppearance {
        return sharedTicketViewAppearance
    }
    
    // Font
    open var cellsBoldFontName = "HelveticaNeue-Bold"
    open var cellsLightFontName = "HelveticaNeue"
    open var cellsFontSize: CGFloat = 17
    
    // TicketView
    open var ticketViewContainerMargin: CGFloat = 0
    open var strokeColor = UIColor.lightGray // color of the cell's outline
    open var fillColor = UIColor.clear // fills the inside color of the cell
    open var lineWidth:CGFloat = 1.5 // width of the cell's outline
    open var cellsMargin:CGFloat = 6.5 // space between elements inside the cell
    open var circleInvertedRadius:CGFloat = 12.0 // Increasing this value decreases the TicketView hole size and viceversa
    
    // Cells height
    open var cellsHeight:CGFloat = 80.0
    
    // Cells background color
    open var cellsBackgroundColor: UIColor?
    open var topCellBackgroundColor = UIColor.white
    open var midCellBackgroundColor = UIColor.white
    open var multipleMidCellBackgroundColor = UIColor.white
    open var bottomCellBackgroundColor = UIColor.white
    open var singleBottomCellBackgroundColor = UIColor.white
    
    // Labels background color
    open var topCellUpperLeftLabelBackgroundColor = UIColor.clear
    open var topCellBottomLeftLabelBackgroundColor = UIColor.clear
    open var topCellUpperRightLabelBackgroundColor = UIColor.clear
    open var topCellBottomRightLabelBackgroundColor = UIColor.clear
    
    // Plane image
    open var planeImage = UIImage(named: "planeFlight") // top cell image
    
    // Content mode
    open var imageContentMode = UIViewContentMode.scaleAspectFit
    
    // Animations
    open var animated = true // animates the TicketView cells
    
    // Date format
    open var dateFormat = "HH:mm"
    open var flightHoursAdditionalText = "hrs"
}

