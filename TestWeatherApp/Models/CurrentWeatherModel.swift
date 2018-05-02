//
//  CurrentWeatherModel.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 02/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherModel {
    var cityName: String?
    var temperature: String?
    var weatherCondition: String?
    var humidity: String?
    var precipitationProbability: String?
    var pressure: String?
    var windSpeed: String?
    var windDeg: Double?
    var windDirection: String?
    var icon: UIImage?
    
    init(models: CurrentWeather) {
        self.cityName = models.cityName
        self.weatherCondition = models.weatherCondition
        
        self.temperature = CurrentWeatherModel.formatValue(value: models.tempCelsius, endStringWith: "°")
        
        
        self.humidity = CurrentWeatherModel.formatValue(value: models.humidity, endStringWith: "%")
        
        self.precipitationProbability = CurrentWeatherModel.formatValue(value: models.precipitationProbability, endStringWith: " mm", castToInt: false)
        
        self.pressure = CurrentWeatherModel.formatValue(value: models.pressure, endStringWith: " hPa")
        
        self.windSpeed = CurrentWeatherModel.formatValue(value: models.windSpeed, endStringWith: " km/h")
        
        self.windDeg = models.windDeg
        
        self.windDirection = "NE"
        
        let weatherIcon = WeatherImage(iconString: models.icon)
        self.icon = weatherIcon.image
    }
    
    static func formatValue(value: Double, endStringWith: String = "", castToInt: Bool = true) -> String {
        var returnValue: String
        let defaultString = "-"
        
        if value == Double.infinity {
            returnValue = defaultString
        } else if castToInt {
            returnValue = "\(Int(value))"
        } else {
            returnValue = "\(value)"
        }
        
        return returnValue.appending(endStringWith)
    }
}
