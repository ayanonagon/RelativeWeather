//
//  RelativeWeatherForecastTests.swift
//  RelativeWeather
//
//  Created by Ayaka Nonaka on 6/14/14.
//  Copyright (c) 2014 Ayaka Nonaka. All rights reserved.
//

import XCTest
import RelativeWeather

class RelativeWeatherForecastTests : XCTestCase {

    func testInit() {
        let forecast : RelativeWeatherForecast = RelativeWeatherForecast()
        XCTAssertNil(forecast.currentCondition)
        XCTAssertNil(forecast.tomorrowCondition)

        XCTAssertNil(forecast.yesterdayHigh)
        XCTAssertNil(forecast.todayHigh)
        XCTAssertNil(forecast.tomorrowHigh)

        XCTAssertNil(forecast.yesterdayLow)
        XCTAssertNil(forecast.todayLow)
        XCTAssertNil(forecast.tomorrowLow)
    }

    func testUpdateWithResponse() {
        let forecast : RelativeWeatherForecast = RelativeWeatherForecast()

        let filePath = NSBundle(forClass:RelativeWeatherForecastTests.classForKeyedArchiver()).pathForResource("WundergroundResponse", ofType:"json")
        let fileString = NSString.stringWithContentsOfFile(filePath, encoding:NSUTF8StringEncoding, error:nil)
        let responseData : NSData = fileString.dataUsingEncoding(NSUTF8StringEncoding)
        let response : AnyObject! = NSJSONSerialization.JSONObjectWithData(responseData, options:NSJSONReadingOptions(0), error:nil)

        forecast.__update(response as NSDictionary)

        XCTAssertEqual(forecast.currentCondition!, "Cloudy with a chance of meatballs")
        XCTAssertEqual(forecast.tomorrowCondition!, "Partly Cloudy")

        XCTAssertEqual(forecast.yesterdayHigh!, 27)
        XCTAssertEqual(forecast.todayHigh!, 23)
        XCTAssertEqual(forecast.tomorrowHigh!, 20)

        XCTAssertEqual(forecast.yesterdayLow!, 12)
        XCTAssertEqual(forecast.todayLow!, 11)
        XCTAssertEqual(forecast.tomorrowLow!, 11)
    }
}
