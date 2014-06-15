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

    XCTAssertEqualWithAccuracy(forecast.yesterdayHigh, 0.0, 0.001)
    XCTAssertEqualWithAccuracy(forecast.todayHigh, 0.0, 0.001)
    XCTAssertEqualWithAccuracy(forecast.tomorrowHigh, 0.0, 0.001)

    XCTAssertEqualWithAccuracy(forecast.yesterdayLow, 0.0, 0.001)
    XCTAssertEqualWithAccuracy(forecast.todayLow, 0.0, 0.001)
    XCTAssertEqualWithAccuracy(forecast.tomorrowLow, 0.0, 0.001)
  }

}
