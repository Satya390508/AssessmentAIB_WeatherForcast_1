//
//  ForecastVC.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var cityID: Int64?
	var forecastCollectionObj: CollectionModel?
	
	
	@IBOutlet weak var lbl_count: UILabel!
	@IBOutlet weak var tableView: UITableView!

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.tableView.isHidden = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if self.cityID == nil {
			let alert = UIAlertController(title: "Bad Choice!", message: "Forecast can not be retrieved for current selection.", preferredStyle: .alert)
			let cancelAction = UIAlertAction(title: "Select Again", style: .cancel) { (_) in
				if self.navigationController != nil {
					self.navigationController?.popViewController(animated: true)
				}
				else {
					self.dismiss(animated: true, completion: nil)
				}
			}
			alert.addAction(cancelAction)
			self.present(alert, animated: true, completion: nil)
		}
		else {
			WebServiceHandler().getWeatherForcastForCity(cityID: self.cityID!) { (receivedForecast, errorMsg) in
				if errorMsg != nil {
					// TODO: Add Appropriate Alert
					print(errorMsg!);
				}
				
				if let forecastCollection = receivedForecast, forecastCollection.cnt > 0 {
					self.forecastCollectionObj = forecastCollection
					
					// Populate Forecast Collection in UIs
					DispatchQueue.main.async {
						self.lbl_count.text = "Total forecasts loaded : \(self.forecastCollectionObj!.cnt)"
						self.tableView.isHidden = false
						self.tableView.reloadData()
					}
				}
				else {
					// TODO: Add Appropriate Alert
					print("Empty Forecast Received");
				}
			}
		}
	}

	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
	// MARK:- TableView Datasource functions
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.forecastCollectionObj?.cnt ?? 0
	}
	
	//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	//		return (self.collectionObj != nil) ? 270 : 0
	//	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tftvCell = tableView.dequeueReusableCell(withIdentifier: "ForecastTVCell", for: indexPath) as! ForecastTVCell
		
		let forecastObj = self.forecastCollectionObj?.list[indexPath.row]
		tftvCell.updateCellWithForecast(forecastObj!)
		
		return tftvCell
	}
	
	@IBAction func onClickedCloseButton(_ sender: Any) {
		
		if self.navigationController != nil {
			self.navigationController?.popViewController(animated: true)
		}
		else {
			self.dismiss(animated: true, completion: nil)
		}
	}
}
