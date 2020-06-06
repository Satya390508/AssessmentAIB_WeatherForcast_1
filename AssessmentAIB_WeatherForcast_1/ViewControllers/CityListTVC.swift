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
	let loadingHud = JGProgressHUD(style: .dark)

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		self.tableView.tableFooterView = UIView() // To remove unwanted empty cell at the bottom of table
		
		self.refreshTableData()
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
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	// MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
	func refreshTableData() {
		if reachabilityObj.connection == .unavailable {
			self.showAlert(title: KTITLE_NetworkError, message: KMSG_NetworkError+KMSG_RetryCityList, shouldTryAgain: true)
			return
		}
		
		self.loadingHud.textLabel.text = "Loading..."
		self.loadingHud.show(in: self.view)
		WebServiceHandler().getCityList { (cityList, errorMsg) in
			DispatchQueue.main.async {
				self.loadingHud.dismiss()
			}
			
			if errorMsg != nil {
				// TODO: Add Appropriate Alert
				print(errorMsg!);
			}
			
			if let cityList = cityList, cityList.count > 0 {
				// Show/Update list of cities received from server
				print("City List Parsing completed => \(cityList.count)")
				self.cityList = cityList
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
			else {
				// TODO: Add Appropriate Alert
				print("Empty List Received");
			}
		}
	}
	
	func showAlert(title:String?, message: String, shouldTryAgain: Bool = false) {
		let alert = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)
		let cancelAction = UIAlertAction(title:shouldTryAgain ? "Cancel" : "Ok", style: .cancel, handler: nil)
		alert.addAction(cancelAction)
		
		if shouldTryAgain {
			let retryAction = UIAlertAction(title: "Try again", style: .default) { (retryAction) in
				self.refreshTableData()
			}
			alert.addAction(retryAction)
		}
		DispatchQueue.main.async {
			self.present(alert, animated: false, completion: nil)
		}
	}
}
