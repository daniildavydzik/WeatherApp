//
//  CurrentWeatherTest.swift
//  TestWeatherAppTests
//
//  Created by Daniel Davydzik on 02/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import XCTest
@testable import Pods_TestWeatherApp
@testable import TestWeatherApp
extension ForecastWeather {
    static func validJson() -> [String: Any]{
        return [
            "dt": 23.0  ,
            "temp": ["day" : 24.0],
            "weather": [ ["main" : "Cloudy", "icon": "BlueSky"] , ["current" : true, "dry": 25.0]]
        
        ]
    }
}

class CurrentWeatherTest: XCTestCase {
    
    var forecastWeather : ForecastWeather!
    var json : [String: AnyObject]?
    override func setUp() {
        super.setUp()
        json = ForecastWeather.validJson() as [String: AnyObject]
        forecastWeather = ForecastWeather(json: json!)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testThatJSONSuccessefullyParse(){
        json!["dt"] = nil
        forecastWeather = ForecastWeather(json: json!)
        
        XCTAssertTrue(forecastWeather.date == Double.infinity && forecastWeather.temperature != Double.infinity && forecastWeather.icon != "" && forecastWeather.weatherCondition != "", "should parse infinity for missing date")
        

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
