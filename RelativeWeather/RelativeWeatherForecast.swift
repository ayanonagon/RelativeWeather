//
//  RelativeWeatherForecast.swift
//  RelativeWeather
//
//  Created by Ayaka Nonaka on 6/14/14.
//  Copyright (c) 2014 Ayaka Nonaka. All rights reserved.
//

import Foundation
import CoreLocation

public class RelativeWeatherForecast {

    public var currentCondition : String?
    public var tomorrowCondition : String?

    public var yesterdayHigh : Float?
    public var todayHigh : Float?
    public var tomorrowHigh : Float?

    public var yesterdayLow : Float?
    public var todayLow : Float?
    public var tomorrowLow : Float?

    public init() {
    }

    public func update(location: CLLocationCoordinate2D) {
        let manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let urlString = "http://api.wunderground.com/api/ACCESS_TOKEN/conditions/forecast/yesterday/q/\(location.latitude),\(location.longitude).json"
        Alamofire.request(.GET, urlString).response { (request, response, data, error) in
            self.__update(JSONValue(data as NSData))
        }
    }

    func __update(response: JSONValue) {
        let yesterday = response["history"]["dailysummary"][0]
        if let yesterdayHigh = yesterday["maxtempm"].string {
            self.yesterdayHigh = (yesterdayHigh as NSString).floatValue
        }
        if let yesterdayLow = yesterday["mintempm"].string {
            self.yesterdayLow = (yesterdayLow as NSString).floatValue
        }

        let forecast = response["forecast"]["simpleforecast"]["forecastday"]

        let today = forecast[0]
        self.currentCondition = today["conditions"].string
        if let todayHigh = today["high"]["celsius"].string {
            self.todayHigh = (todayHigh as NSString).floatValue
        }
        if let todayLow = today["low"]["celsius"].string {
            self.todayLow = (todayLow as NSString).floatValue
        }

        let tomorrow = forecast[1]
        self.tomorrowCondition = tomorrow["conditions"].string
        if let tomorrowHigh = tomorrow["high"]["celsius"].string {
            self.tomorrowHigh = (tomorrowHigh as NSString).floatValue
        }
        if let tomorrowLow = tomorrow["low"]["celsius"].string {
            self.tomorrowLow = (tomorrowLow as NSString).floatValue
        }
    }

}
