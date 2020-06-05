//
//  ForecastTVCell.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import UIKit

class ForecastTVCell: UITableViewCell {
	
	@IBOutlet weak var lbl_WeatherDesc: UILabel!
	@IBOutlet weak var lbl_WindDesc: UILabel!
	@IBOutlet weak var lbl_Clouds: UILabel!
	
	@IBOutlet weak var lbl_MaxTemp: UILabel!
	@IBOutlet weak var lbl_CurrentTemp: UILabel!
	@IBOutlet weak var lbl_MinTemp: UILabel!
	
	@IBOutlet weak var lbl_Pressure: UILabel!
	@IBOutlet weak var lbl_SeaLevel: UILabel!
	@IBOutlet weak var lbl_GrndLevel: UILabel!
	@IBOutlet weak var lbl_Humidity: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func updateCellWithForecast(_ forecast: ForcastModel) {
		
		self.lbl_WeatherDesc.text = "Weather : \(forecast.weather?.first?.description ?? "Not Available")"
		self.lbl_WindDesc.text = "Wind > Speed: \(forecast.wind?.speed ?? 0) >> Deg : \(forecast.wind?.deg ?? 0)"
		self.lbl_Clouds.text = "Clouds : \(forecast.clouds?.all ?? 0)"
		
		self.lbl_MaxTemp.text = "Max : \(forecast.main?.temp_max ?? 0)"
		self.lbl_CurrentTemp.text = "Current : \(forecast.main?.temp ?? 0)"
		self.lbl_MinTemp.text = "Min : \(forecast.main?.temp_min ?? 0)"
		
		self.lbl_Pressure.text = "Pressure : \(forecast.main?.pressure ?? 0)"
		self.lbl_SeaLevel.text = "Sea Level : \(forecast.main?.sea_level ?? 0)"
		self.lbl_GrndLevel.text = "Ground Levle : \(forecast.main?.grnd_level ?? 0)"
		self.lbl_Humidity.text = "Max : \(forecast.main?.humidity ?? 0)"
	}

}
