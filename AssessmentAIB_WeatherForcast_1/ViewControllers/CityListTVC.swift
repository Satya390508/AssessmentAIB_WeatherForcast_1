//
//  CityListTVC.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import UIKit
import  Reachability
import JGProgressHUD

class CityListTVC: UITableViewController {
	
	var cityList = [CityModel]()
	let reachabilityObj = try! Reachability()
//	let loadingHud = JGProgressHUD(style: .dark) // Removing hud from this VC as the same info is updated via pull to refresh control
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		self.refreshControl?.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
		self.tableView.setEmptyMessage(KMSG_CityList_NoData+KMSG_PullToRefresh)
//		self.refreshTableData() // Commented the first time use to avoid overlapping of Webservice calls
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return self.cityList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CityNameCell", for: indexPath)
		
		// Configure the cell...
		cell.textLabel?.text = self.cityList[indexPath.row].name
		cell.detailTextLabel?.text = "\(self.cityList[indexPath.row].coord)"
		
		return cell
	}
	
	// MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		if self.refreshControl!.isRefreshing {
			self.showAlert(title: "Selection Error!", message: "Can not process this request now as the city list is being updated")
			return
		}
		
		if reachabilityObj.connection == .unavailable {
			self.showAlert(title: KTITLE_NetworkError, message: KMSG_NetworkError+KMSG_SelectCityAgain)
			return
		}

		let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "ForecastVC") as!  ForecastVC
		detailVC.cityID = cityList[indexPath.row].id
		detailVC.cityName = cityList[indexPath.row].name
		DispatchQueue.main.async {
			self.present(detailVC, animated: true, completion: nil)
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
	
	// MARK: - Custom Methods
	@objc func refreshTableData() {
		if reachabilityObj.connection == .unavailable {
			self.showAlert(title: KTITLE_NetworkError, message: KMSG_CityList_failed+KMSG_NetworkError)
			return
		}
		
//		self.loadingHud.textLabel.text = "Loading..."
//		self.loadingHud.show(in: self.view)
		WebServiceHandler().getCityList { (cityList, errorMsg) in
			DispatchQueue.main.async {
//				self.loadingHud.dismiss()
				if self.refreshControl!.isRefreshing {
					self.refreshControl!.endRefreshing()
				}
				
				if errorMsg != nil {
					// Instead of using Alert, used the table view background view to show the error message
					// This way, We can ask the user to pull to refresh
					self.tableView.setEmptyMessage(errorMsg!+KMSG_PullToRefresh)
					return
				}
				
				if let cityList = cityList, cityList.count > 0 {
					// Show/Update list of cities received from server
					print("City List Parsing completed => \(cityList.count)")
					self.cityList = cityList
					self.tableView.restore()
					self.tableView.reloadData()
				}
				else {
					// Instead of using Alert, used the table view background view to show the empty message
					// This way, We can ask the user to pull to refresh
					self.tableView.setEmptyMessage(KMSG_CityList_Empty + KMSG_PullToRefresh)
				}
			}
		}
	}
	
	func showAlert(title:String?, message: String) {
		
		DispatchQueue.main.async {			
			let alert = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)
			let cancelAction = UIAlertAction(title:"Ok", style: .cancel, handler: nil)
			alert.addAction(cancelAction)
			
			self.present(alert, animated: false, completion: nil)
		}
	}
}

