//
//  PermissionViewController.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 01/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import UIKit
import CoreLocation


class PermissionsViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var permissionMessageLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let myImage = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var imageConstraints:[NSLayoutConstraint] = []
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkForGrantedLocationPermissions()
    }
    @IBAction func askForLocationPermission(_ sender: UIButton) {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                self.displayLocationPermissionsDenied()
                let alert = UIAlertController(title: "Alert", message: Constants.ACTIVE_LOCATION_PERMISSIONS, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .authorizedAlways, .authorizedWhenInUse:
                self.authorizationCompleted()
            }
        } else {
            self.displayLocationPermissionsDenied()
        }
    }
    
    // MARK: - View Methods
    func checkForGrantedLocationPermissions() {
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.manageLocationStatus(status: CLLocationManager.authorizationStatus())
            } else {
                self.displayLocationPermissionsDenied()
            }
        }
    }
    
    func manageLocationStatus(status: CLAuthorizationStatus) {
        switch(status) {
        case .notDetermined:
            self.displayLocationPermissionsNotDeterminated()
        case .restricted, .denied:
            self.displayLocationPermissionsDenied()
        case .authorizedAlways, .authorizedWhenInUse:
            self.authorizationCompleted()
        }
    }
    
    func displayLocationPermissionsDenied() {
        self.permissionMessageLabel.text = Constants.MESSAGE_DENIED_LOCATION_PERMISSIONS
    }
    
    func displayLocationPermissionsNotDeterminated() {
        self.permissionMessageLabel.text = Constants.MESSAGE_REQUEST_LOCATION_PERMISSIONS
    }
    
    func authorizationCompleted() {
        dismiss(animated: true)
    }
    
}

// MARK: - Extensions
extension PermissionsViewController: CLLocationManagerDelegate {
    // the authorization status for the application changed
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus){
        self.manageLocationStatus(status: status)
    }
}
