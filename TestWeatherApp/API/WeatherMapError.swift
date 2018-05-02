//
//  WeatherMapError.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 01/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import Foundation

enum OpenWeatherMapError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidaData
    case jsonConversionFailure
    case invalidUrl
    case jsonParsingFailure
    case statusUnavailable
}
