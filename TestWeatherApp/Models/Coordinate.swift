//
//  Coordinate.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 01/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import Foundation
import CoreLocation

struct Coordinate {
    static var sharedInstance = Coordinate(latitude: 0.0, longitude: 0.0)
    
    static let locationManager = CLLocationManager()
    
    typealias CheckLocationPermissionsCompletionHandler = (Bool) -> Void
    static func checkForGrantedLocationPermissions(completionHandler completion: @escaping CheckLocationPermissionsCompletionHandler) {
        let locationPermissionsStatusGranted = CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        
        if locationPermissionsStatusGranted {
            let currentLocation = locationManager.location
            Coordinate.sharedInstance.latitude = (currentLocation?.coordinate.latitude)!
            Coordinate.sharedInstance.longitude = (currentLocation?.coordinate.longitude)!
        }
        
        completion(locationPermissionsStatusGranted)
    }
    
    var latitude: Double
    var longitude: Double
}
