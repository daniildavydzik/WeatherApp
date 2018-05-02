//
//  ViewController.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 01/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class MainViewController: UIViewController {
    
   
    // MARK: - Properties
    @IBOutlet weak var currentWeatherCondition: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    
    var forecastWeatherViewModels: [ForecastWeatherViewModel] = []
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
   // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getCurrentWeather()
        self.checkPermissions()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkPermissions() {
        Coordinate.checkForGrantedLocationPermissions() { [unowned self] allowed in
            if allowed {
                self.locationManager.requestLocation()
                self.getForecastWeather()
            }else {
                self.showPermissionsScreen()
            }
        }
    }
    
    
    func showPermissionsScreen() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.REQUEST_PERMISSIONS_SEGUE_ID) {
            self.present(vc, animated: true)
        }
    }
    
    // MARK: - Weather Getters
    
    func getForecastWeather(){
        DispatchQueue.main.async {
            WeatherAPIClient.client.getForecastWeather(at: Coordinate.sharedInstance) {
                [unowned self] forecastsWeather, error in
                
                if let forecastsWeather = forecastsWeather {
                    if forecastsWeather.count > 0 {
                        self.forecastWeatherViewModels = []
                    }
                    
                    for forecastWeather in forecastsWeather {
                        let forecastWeatherVM = ForecastWeatherViewModel(model: forecastWeather)
                        self.forecastWeatherViewModels.append(forecastWeatherVM)
                    }}
                    self.tableView.reloadData()

                }
        }
    }

    func getCurrentWeather() {
        DispatchQueue.main.async {
            WeatherAPIClient.client.getCurrentWeather(at: Coordinate.sharedInstance) {
                [unowned self] currentWeather, error in
                if let currentWeather = currentWeather {
                    let CurrentWeatherViewModel = CurrentWeatherModel(models: currentWeather)
                    self.displayWeather(viewModel: CurrentWeatherViewModel)
                   
                }
            }
        }
    }

    
    // MARK: - UpdateUI
    func displayWeather(viewModel: CurrentWeatherModel) {
        self.currentWeatherIcon.image = viewModel.icon
        self.currentTemperatureLabel.text = "\(viewModel.temperature!)"
        self.currentWeatherCondition.text = viewModel.weatherCondition
        self.cityNameLabel.text = viewModel.cityName
    }
    

}


// MARK: - Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastWeatherViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastWeatherVM = self.forecastWeatherViewModels[indexPath.row]
        
        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORECAST_CELL_SEGUE_ID, for: indexPath) as! ForecastTableViewCell
        
        // Configure Cell
        cell.forecastImage.image = forecastWeatherVM.icon
        cell.weekDayLabel.text = forecastWeatherVM.weekday
        cell.weatherConditionLabel.text = forecastWeatherVM.weatherCondition
        cell.temperatureLabel.text = forecastWeatherVM.temperature
        
        return cell
    }
}


extension MainViewController: CLLocationManagerDelegate {
    // new location data is available
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // update shaped instance
        Coordinate.sharedInstance.latitude = (manager.location?.coordinate.latitude)!
        Coordinate.sharedInstance.longitude = (manager.location?.coordinate.longitude)!
        
    }
    
    // the location manager was unable to retrieve a location value
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        Coordinate.checkForGrantedLocationPermissions() { allowed in
            if !allowed {
                //   self.showPermissionsScreen()
            }
        }
    }
    
    
}
