//
//  ForecastTableViewCell.swift
//  TestWeatherApp
//
//  Created by Daniel Davydzik on 02/05/2018.
//  Copyright © 2018 Daniel Davydzik. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
//    @IBOutlet weak var forecastImage: UIImageView!
//
//    @IBOutlet weak var temperatureLabel: UILabel!
//    @IBOutlet weak var weatherConditionLabel: UILabel!
//    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
