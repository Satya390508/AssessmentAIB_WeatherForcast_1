//
//  ForcastModels.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import Foundation

struct TemperatureModel: Codable {
	let temp: Double
	let temp_min: Double
	let temp_max: Double
	let pressure: Double
	let sea_level:Double
	let grnd_level:Double
	let humidity:Double
	let temp_kf:Double
}

struct WeatherModel: Codable {
	let id: Int
	let main: String
	let description: String
	let icon: String
}

struct CloudModel: Codable {
	let all: Double // for cloudiness %
}

struct WindModel: Codable {
	let speed: Double
	let deg: Double
}

struct RainModel: Codable {
	let last3h: Double
	enum RainKeys: String, CodingKey {
		case last3h = "3h" // for rain volume for last 3 hours
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: RainKeys.self)
		self.last3h = try container.decodeIfPresent(Double.self, forKey: .last3h) ?? 0.0
	}
}

struct SnowModel: Codable {
	let last3h: Double
	enum SnowKeys: String, CodingKey {
		case last3h = "3h" // for snow volume for last 3 hours
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: SnowKeys.self)
		self.last3h = try container.decodeIfPresent(Double.self, forKey: .last3h) ?? 0.0
	}
}

struct SysModel: Codable {
	let pod: String
}

struct ForcastModel: Codable {
	let dt: Int64
	let main: TemperatureModel?
	let weather: [WeatherModel]?
	let clouds: CloudModel?
	let wind: WindModel?
	let rain: RainModel?
	let snow: SnowModel?
	let sys: SysModel?
	let dt_txt: String
}

struct CollectionModel: Codable {
	let cod: String
	let message: Double
	let cnt: Int
	let list:[ForcastModel]
	let city:CityModel
}
