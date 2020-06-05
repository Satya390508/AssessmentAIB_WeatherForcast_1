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
		WebServiceHandler().getCityList();
		// TODO: - Need to show list of cities received from server
		
		
		
		// Testing the forcast API
		WebServiceHandler().getWeatherForcastForCity(cityID: Int64(KURL_TEST_CITYID), successHandler: { (forcastObj) in
			// TODO: Add details view
			print("Parsing data successfull ===> \(forcastObj)")
		}) { (errorMessage) in
			// TODO: Add Appropriate Alert
			print("Error occured for forcast ===> \(errorMessage)")
		}
	}
}

