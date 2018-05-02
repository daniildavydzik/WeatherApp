//
//  ForecastWeatherModel.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 02/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import Foundation
import UIKit

struct ForecastWeatherViewModel {
    var weekday: String?
    var temperature: String?
    var weatherCondition: String?
    var icon: UIImage?
    private let defaultString = "-"
    
    init(model: ForecastWeather) {
        self.weekday = ForecastWeatherViewModel.getDayOfWeek(from: model.date)
        self.weatherCondition = model.weatherCondition
        self.temperature = CurrentWeatherModel.formatValue(value: model.temperature, endStringWith: "°")
        let weatherIcon = WeatherImage(iconString: model.icon)
        self.icon = weatherIcon.image
    }
    
    static func getDayOfWeek(from fromDate: Double) -> String {
        let date = Date(timeIntervalSince1970: fromDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dateFormatter.string(from: date)
        
        return dayOfWeekString
    }
    
}
