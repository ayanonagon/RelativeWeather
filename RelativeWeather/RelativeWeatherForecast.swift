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
        if let history = response["history"] as? NSDictionary {
            if let dailySummary = history["dailysummary"] as? NSArray {
                if let yesterday = dailySummary[0] as? NSDictionary {
                    if let yesterdayHighString = yesterday["maxtempm"] as? NSString {
                        self.yesterdayHigh = yesterdayHighString.floatValue
                    }
                    if let yesterdayLowString = yesterday["mintempm"] as? NSString {
                        self.yesterdayLow = yesterdayLowString.floatValue
                    }
                }
            }
        }
        if let forecast = response["forecast"] as? NSDictionary {
            if let simpleForecast = forecast["simpleforecast"] as? NSDictionary {
                if let forecastDay = simpleForecast["forecastday"] as? NSArray {
                    if let today = forecastDay[0] as? NSDictionary {
                        if let todayCondition = today["conditions"] as? String {
                            self.currentCondition = todayCondition
                        }
                        if let todayHighDict = today["high"] as? NSDictionary {
                            if let todayHighString = todayHighDict["celsius"] as? NSString {
                                self.todayHigh = todayHighString.floatValue
                            }
                        }
                        if let todayLowDict = today["low"] as? NSDictionary {
                            if let todayLowString = todayLowDict["celsius"] as? NSString {
                                self.todayLow = todayLowString.floatValue
                            }
                        }
                    }
                    if let tomorrow = forecastDay[1] as? NSDictionary {
                        if let tomorrowCondition = tomorrow["conditions"] as? String {
                            self.tomorrowCondition = tomorrowCondition
                        }
                        if let tomorrowHighDict = tomorrow["high"] as? NSDictionary {
                            if let tomorrowHighString = tomorrowHighDict["celsius"] as? NSString {
                                self.tomorrowHigh = tomorrowHighString.floatValue
                            }
                        }
                        if let tomorrowLowDict = tomorrow["low"] as? NSDictionary {
                            if let tomorrowLowString = tomorrowLowDict["celsius"] as? NSString {
                                self.tomorrowLow = tomorrowLowString.floatValue
                            }
                        }
                    }
                }
            }
        }
    }

}
