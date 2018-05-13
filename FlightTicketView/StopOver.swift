//
//  StopOver.swift
//
//  Created by Manuel Bulos on 5/9/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import UIKit
import Foundation

open class StopOver {
    public var id: Int
    public var airlineName: String
    public var airlineLogo: UIImage
    public var departureTime: Date
    public var arrivalTime: Date
    public var departureCity: String
    public var arrivalCity: String
    
    public init(id:Int,airlineName:String,airlineLogo:UIImage,departureTime:Date,arrivalTime:Date,departureCity:String,arrivalCity:String) {
        self.id = id
        self.airlineName = airlineName
        self.airlineLogo = airlineLogo
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.departureCity = departureCity
        self.arrivalCity = arrivalCity
    }
    
}
