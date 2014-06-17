//
//  RelativeWeatherForecast.swift
//  RelativeWeather
//
//  Created by Ayaka Nonaka on 6/14/14.
//  Copyright (c) 2014 Ayaka Nonaka. All rights reserved.
//

import Foundation
import CoreLocation

class RelativeWeatherForecast {

    var currentCondition : String?
    var tomorrowCondition : String?

    var yesterdayHigh : Float?
    var todayHigh : Float?
    var tomorrowHigh : Float?

    var yesterdayLow : Float?
    var todayLow : Float?
    var tomorrowLow : Float?

    init() {
    }

    func update(location: CLLocationCoordinate2D) {
        let manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let urlString = "http://api.wunderground.com/api/ACCESS_TOKEN/conditions/forecast/yesterday/q/\(location.latitude),\(location.longitude).json"
        manager.GET(urlString,
            parameters:nil,
            success:{
                (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                if let response = responseObject as? NSDictionary {
                    self.__update(response)
                }
            },
            failure:{
                (operation: AFHTTPRequestOperation!, error: AnyObject!) -> Void in
            }
        )
    }

    func __update(response: NSDictionary) {
        let dailySummary = response.valueForKeyPath("history.dailysummary") as NSArray
        let yesterday = dailySummary.objectAtIndex(0) as NSDictionary
        self.yesterdayHigh = yesterday.valueForKey("maxtempm").floatValue
        self.yesterdayLow = yesterday.valueForKey("mintempm").floatValue

        let forecast = response.valueForKeyPath("forecast.simpleforecast.forecastday") as NSArray

        let today = forecast.objectAtIndex(0) as NSDictionary
        self.currentCondition = today.valueForKey("conditions") as NSString
        self.todayHigh = today.valueForKeyPath("high.celsius").floatValue
        self.todayLow = today.valueForKeyPath("low.celsius").floatValue

        let tomorrow = forecast.objectAtIndex(1) as NSDictionary
        self.tomorrowCondition = tomorrow.valueForKey("conditions") as NSString
        self.tomorrowHigh = tomorrow.valueForKeyPath("high.celsius").floatValue
        self.tomorrowLow = tomorrow.valueForKeyPath("low.celsius").floatValue
    }

}
