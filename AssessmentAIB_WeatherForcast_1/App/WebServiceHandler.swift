//
//  WebServiceHandler.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import Foundation

class WebServiceHandler {
	
	func getCityList() {
		
		let sessionConfig = URLSessionConfiguration.default
		let session = URLSession(configuration: sessionConfig)
		let dlUrl = URL(string: KURL_CITYLISTFILE)!
		let dlTask = session.downloadTask(with: dlUrl) { (receivedUrl, receivedResponse, error) in
			
			if let responseError = error {
// TODO:- Add failure Handler here for error occured in web service call
			}
			
			if let httpResponse = receivedResponse as? HTTPURLResponse {
				if httpResponse.statusCode != 200 {
// TODO:- Add failure Handler here for "Server response error"
					return
				}
			}
			
			if let downloadedData = try? Data(contentsOf: receivedUrl!) {
				print("Size of downloaded zipped file ==> \(downloadedData.count)")
// TODO:- Add Handlers here to process the successfully received Data i.e. Zipped file handler
			}
			else {
// TODO:- Add failure Handler here for "Cily List Download failed"
			}
		}
		dlTask.resume()
	}
	
	func getWeatherForcastForCity(cityID: Int64) {
		
		var urlComponents = URLComponents()
		urlComponents.scheme = KURL_BASE_FORCAST_SCHEME
		urlComponents.host = KURL_BASE_FORCAST_HOST
		urlComponents.path = KURL_BASE_FORCAST_PATH
		urlComponents.queryItems = [
			URLQueryItem(name: KURL_KEY_CITYID, value: "\(cityID)"),
			URLQueryItem(name: KURL_KEY_APPID, value: KURL_APPID)
		]
		
		
		let sessionConfig = URLSessionConfiguration.default
		let session = URLSession(configuration: sessionConfig)
		let task = session.dataTask(with: urlComponents.url!) { (receivedData, recievedResponse, error) in
			
// TODO: - Handle the forcast data received from the API
			print("City ID Based Url data length => \(receivedData!.count)")
		}
		task.resume()
	}

}
