//
//  CityModels.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import Foundation

struct GeoLocation: Codable {
	let latitude: Double
	let longitude: Double
	
	enum GeoLocationStructKeys: String, CodingKey {
		case lat, lon
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: GeoLocationStructKeys.self)
		self.latitude = try values.decodeIfPresent(Double.self, forKey: .lat) ?? 0.0
		self.longitude = try values.decodeIfPresent(Double.self, forKey: .lon) ?? 0.0
	}
}

struct CityModel: Codable {
	let country: String
	let state: String?
	let id: Int64
	let name: String
	let coord: GeoLocation
}
