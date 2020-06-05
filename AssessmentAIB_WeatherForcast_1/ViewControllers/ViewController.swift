//
//  ViewController.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Testing the cityList API
		WebServiceHandler().getCityList { (cityList, errorMsg) in
			if errorMsg != nil {
				// TODO: Add Appropriate Alert
				print(errorMsg!);
			}
			
			if let cityList = cityList, cityList.count > 0 {
				// TODO: - Show list of cities received from server
				print("City List Parsing completed => \(cityList.count)")
			}
			else {
				// TODO: Add Appropriate Alert
				print("Empty List Received");
			}
		}
		
		
		// Testing the forcast API
		WebServiceHandler().getWeatherForcastForCity(cityID: Int64(KURL_TEST_CITYID)) { (forecastCollection, errorMsg) in
			if errorMsg != nil {
				// TODO: Add Appropriate Alert
				print(errorMsg!);
			}
			
			if let forecastObj = forecastCollection {
				// TODO: - Show details of forcast for the city received from server
				print("City Forecast Details are => \(forecastObj)")
			}
			else {
				// TODO: Add Appropriate Alert
				print("No forecast Received for City ");
			}
		}
	}
}

