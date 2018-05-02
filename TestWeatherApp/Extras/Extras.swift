//
//  Extras.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 01/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import Foundation

class Constants {
    // MARK: FirebaseDBProvider - weathers reference
    
    static let WEATHER = "weathers"
    static let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Coordinate.sharedInstance.latitude)&lon=\(Coordinate.sharedInstance.longitude)&appid=7c609f73c5df2dff2f32e3e3cc33cd23"
    // weathers reference properties
    static let WEATHER_CITY = "city"
    static let WEATHER_TEMP = "temperature"
    static let WEATHER_CONDITION = "condition"
    static let DATE = "date"
    static let LATITUDE = "lat"
    static let LONGITUDE = "lon"
    
    // MARK: - Segues
    
    static let REQUEST_PERMISSIONS_SEGUE_ID = "RequestPermissions"
    static let FORECAST_CELL_SEGUE_ID = "ForecastCell"
    
    // MARK: API
    
    static let API_BASE_URL = "http://api.openweathermap.org/data/2.5/"
    static let API_ENDPOINT_CURRENT_WEATHER = "weather/"
    static let API_ENDPOINT_FORECAST_WEATHER = "forecast/daily/"
    
    // MARK: Messages
    
    static let MESSAGE_REQUEST_LOCATION_PERMISSIONS = "Would you like to know the weather in your city? Then allow us know where you are :)"
    static let MESSAGE_DENIED_LOCATION_PERMISSIONS = "You have denied us the location permissions. Please activate them in the Settings of your device to continue."
    static let ACTIVE_LOCATION_PERMISSIONS = "Please activate your location: Settings > Weather Today > Location > While Using the App"
    
    
    
}
