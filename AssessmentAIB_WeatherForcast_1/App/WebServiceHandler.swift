//
//  WebServiceHandler.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import Foundation
import Gzip


class WebServiceHandler {
	
	func getCityList(completionHandler: @escaping ([CityModel]?, String?) -> ()) {
		// Do all the follwing work without double handle
		// Single handler is better to receive
		
		let sessionConfig = URLSessionConfiguration.default
		let session = URLSession(configuration: sessionConfig)
		let dlUrl = URL(string: KURL_CITYLISTFILE)!
		var errMsg: String?
		let dlTask = session.downloadTask(with: dlUrl) { (receivedUrl, receivedResponse, error) in
			
			if let responseError = error {
				errMsg = "Error::\(responseError.localizedDescription)"
				completionHandler(nil, errMsg)
			}
			
			if let httpResponse = receivedResponse as? HTTPURLResponse {
				if httpResponse.statusCode != 200 {
					errMsg = "Error::Server Response::\(httpResponse.statusCode)"
					completionHandler(nil, errMsg)
				}
			}
			
			if let receivedUrl = receivedUrl,  let downloadedData = try? Data(contentsOf: receivedUrl) {
				if downloadedData.isGzipped {
					// Unzip the compressed file
					do {
						let deCompressedData = try downloadedData.gunzipped()
						do {
							// Parse the decompressed Data
							let decodedObj = try JSONDecoder().decode([CityModel].self, from: deCompressedData)
							completionHandler(decodedObj, nil)
						}
						catch let DecodingError.dataCorrupted(context) {
							errMsg = "DecodingError: Corrupted Data ==> " + context.debugDescription
							completionHandler(nil, errMsg)
						}
						catch let DecodingError.keyNotFound(key, context) {
							print("Key '\(key)' not found:", context.debugDescription)
							print("codingPath:", context.codingPath)
							
							errMsg = "Decoding Error: keyNotFound"
							completionHandler(nil, errMsg)
						}
						catch let DecodingError.valueNotFound(value, context) {
							print("Value '\(value)' not found:", context.debugDescription)
							print("codingPath:", context.codingPath)
							errMsg = "Decoding Error: valueNotFound"
							completionHandler(nil, errMsg)
						}
						catch let DecodingError.typeMismatch(type, context)  {
							print("Type '\(type)' mismatch:", context.debugDescription)
							print("codingPath:", context.codingPath)
							errMsg = "Decoding Error: typeMismatch"
							completionHandler(nil, errMsg)
						}
						catch {
							errMsg = "Reading Error::\(error.localizedDescription)"
							completionHandler(nil, errMsg)
						}
					}
					catch {
						// Data could not be decompressed
						errMsg = "Compression error. Could not decompress the list."
						completionHandler(nil, errMsg)
					}
				}
				else {
					// Data was not compressed, Directly parse received Data as JSON
					do {
						let decodedObj = try JSONDecoder().decode([CityModel].self, from: downloadedData)
						completionHandler(decodedObj, nil)
					}
					catch {
						errMsg = "Reading Error::\(error.localizedDescription)"
						completionHandler(nil, errMsg)
					}
				}
			}
			else {
				errMsg = "Error::Empty City List Downloaded"
				completionHandler(nil, errMsg)
			}
		}
		dlTask.resume()
	}

	func getWeatherForcastForCity(cityID: Int64, completionHandler: @escaping (CollectionModel?, String?)->()) {
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
			print("City ID Based Url data length => \(receivedData!.count)")
			if let jsonData = receivedData, jsonData.count > 0 {
				// Data received successfully
				do {
					// Parsing the data
					let forcastCollectionObj = try JSONDecoder().decode(CollectionModel.self, from: jsonData)
					completionHandler(forcastCollectionObj, nil)
				}
				catch {
					print(error)
					completionHandler(nil, error.localizedDescription)
				}
			}
			else {
				completionHandler(nil, "Failed to fetch forcast details")
			}
		}
		task.resume()
	}

}
