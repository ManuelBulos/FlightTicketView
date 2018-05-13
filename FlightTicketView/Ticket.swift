//
//  Ticket.swift
//
//  Created by Manuel Bulos on 5/9/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import Foundation

open class Ticket {
    open var id: Int
    open var departureCityShort: String
    open var departureCityLong: String
    open var arrivalCityShort: String
    open var arrivalCityLong: String
    open var stopOvers: [StopOver]?
    
    public init(id:Int,departureCityShort:String,departureCityLong:String,arrivalCityShort:String,arrivalCityLong:String,stopOvers:[StopOver]?) {
        self.id = id
        self.departureCityShort = departureCityShort
        self.departureCityLong = departureCityLong
        self.arrivalCityShort = arrivalCityShort
        self.arrivalCityLong = arrivalCityLong
        self.stopOvers = stopOvers
    }
}
