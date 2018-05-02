//
//  WeatherAPIClient.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 02/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import Foundation
import Alamofire

class WeatherAPIClient {
    static let client = WeatherAPIClient()
    private var weatherList : [Dictionary<String, AnyObject>]?
    fileprivate let apiKey = "933887d73fafeb70d31b6c5566986168"
    
    lazy var baseUrl: URL = {
        return URL(string: Constants.API_BASE_URL)!
    }()
    
    
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, OpenWeatherMapError?) -> Void
    typealias ForecastWeatherCompletionHandler = ([ForecastWeather]?, OpenWeatherMapError?) -> Void
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(Coordinate.sharedInstance.latitude)&lon=\(Coordinate.sharedInstance.longitude)&appid=7c609f73c5df2dff2f32e3e3cc33cd23") else {
            completion(nil, .invalidUrl)
            return
        }
        
        if InternetAvailability.sharedInstance.isInternetAvailable(){
            Alamofire.request(url).responseJSON { response in
                guard let JSON = response.result.value as? Dictionary<String, AnyObject> else {
                    completion(nil, .invalidaData)
                    return
                }
            
                guard let currentWeather = CurrentWeather(json: JSON) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }
            
                let data: Data = NSKeyedArchiver.archivedData(withRootObject: JSON)
                DataCache.instance.write(data: data, forKey: "CurrentWeather")
                completion(currentWeather, nil)
            }
        }else {
            let data = DataCache.instance.readData(forKey: "CurrentWeather")!
            let weather:Dictionary<String, AnyObject> = (NSKeyedUnarchiver.unarchiveObject(with: data) as? Dictionary<String, AnyObject>)!
            
            guard let currentWeather = CurrentWeather(json: weather) else {
                completion(nil, .jsonParsingFailure)
                return
            }
            
            completion(currentWeather, nil)
        }
    }
    
    
    func getForecastWeather(at coordinate: Coordinate, completionHandler completion: @escaping ForecastWeatherCompletionHandler) {
        
        guard let url = URL(string: Constants.API_ENDPOINT_FORECAST_WEATHER, relativeTo: baseUrl) else {
            completion(nil, .invalidUrl)
            return
        }
        
        let parameters: Parameters = self.buildParameters(coordinate: coordinate)
        
        if InternetAvailability.sharedInstance.isInternetAvailable(){
           Alamofire.request(url, parameters: parameters).responseJSON { response in
            
              guard let JSON = response.result.value else {
                  completion(nil, .invalidaData)
                  return
              }
              var forecasts: [ForecastWeather] = []
                
              if let dict = JSON as? Dictionary<String, AnyObject>{
                
               let data: Data = NSKeyedArchiver.archivedData(withRootObject: dict)
               DataCache.instance.write(data: data, forKey: "ForecastWeather")
               self.weatherList = dict["list"] as? [Dictionary<String, AnyObject>]
                        
               guard let weatherList = self.weatherList else{
                    return
                }
                
               for obj in weatherList {
                 let forecast = ForecastWeather(json: obj)
                 forecasts.append(forecast!)
               }
            }
               completion(forecasts, nil)
           }
        }else {
            var forecasts: [ForecastWeather] = []
            let data = DataCache.instance.readData(forKey: "ForecastWeather")!
            let weather:Dictionary<String, AnyObject> = (NSKeyedUnarchiver.unarchiveObject(with: data) as? Dictionary<String, AnyObject>)!
            self.weatherList = (weather["list"] as? [Dictionary<String, AnyObject>])!
            
            guard let weatherList = self.weatherList else{
                return
            }
            
            for obj in weatherList {
                let forecast = ForecastWeather(json: obj)
                forecasts.append(forecast!)
            }
            
            completion(forecasts, nil)
        }
    }
    
    func buildParameters(coordinate: Coordinate) -> Parameters {
        let parameters: Parameters = [
            "appid": self.apiKey,
            "units": "metric",
            "lat": String(coordinate.latitude),
            "lon": String(coordinate.longitude)
        ]
        
        return parameters
}
}
