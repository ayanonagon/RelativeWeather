//
//  ViewController.swift
//  RelativeWeather
//
//  Created by Ayaka Nonaka on 6/14/14.
//  Copyright (c) 2014 Ayaka Nonaka. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let forecast : RelativeWeatherForecast = RelativeWeatherForecast()

    override func viewDidLoad()  {
        forecast.update(CLLocationCoordinate2DMake(37.842778, -122.246111))
    }
}
