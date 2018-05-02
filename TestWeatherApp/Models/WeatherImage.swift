//
//  WeatherImage.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 01/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import Foundation
import UIKit

enum WeatherImage{
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case mist
    case `default`
    
    init(iconString: String) {
        switch iconString {
        case "01d": self = .clearSky
        case "02d": self = .fewClouds
        case "03d": self = .scatteredClouds
        case "04d": self = .brokenClouds
        case "09d": self = .showerRain
        case "10d": self = .rain
        case "11d": self = .thunderstorm
        case "50d": self = .mist
        default: self = .default
        }
    }
}

extension WeatherImage {
    var image: UIImage {
        switch self {
        case .clearSky: return #imageLiteral(resourceName: "WindIcon")
        case .fewClouds: return #imageLiteral(resourceName: "FewCloudsIcon")
        case .scatteredClouds: return #imageLiteral(resourceName: "FewCloudsIcon")
        case .brokenClouds: return #imageLiteral(resourceName: "FewCloudsIcon")
        case .showerRain: return #imageLiteral(resourceName: "ShowerRainIcon")
        case .rain: return #imageLiteral(resourceName: "ShowerRainIcon")
        case .thunderstorm: return #imageLiteral(resourceName: "ThunderstormIcon")
        case .mist: return #imageLiteral(resourceName: "CloudFogIcon")
        case .default: return #imageLiteral(resourceName: "FewCloudsIcon")
        }
    }
    
}
