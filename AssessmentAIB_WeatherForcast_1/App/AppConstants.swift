//
//  AppConstants.swift
//  AssessmentAIB_WeatherForcast_1
//
//  Created by SatyaRanjan Mohapatra on 05/06/20.
//  Copyright © 2020 SatyaranjanMohapatra. All rights reserved.
//

import Foundation

let KURL_CITYLISTFILE = "https://bulk.openweathermap.org/sample/city.list.json.gz" // To download a zipped file

// Example of forcast URL for JSON response ===> "https://samples.openweathermap.org/data/2.5/forecast?id=CITYID&appid=KURL_APPID"
let KURL_BASE_FORCAST_SCHEME = "https"
let KURL_BASE_FORCAST_HOST = "samples.openweathermap.org"
let KURL_BASE_FORCAST_PATH = "/data/2.5/forecast"
let KURL_TEST_CITYID = 524901 // from smaple api provided in website
let KURL_KEY_CITYID = "id" // Example: id=KURL_TEST_CITYID
let KURL_APPID = "c7b6dfe0f1a9c6c2c3b99247a51e4668" // Received from the website OpenWeather>Mebers>APIKeys
let KURL_KEY_APPID = "appid" // Example: &appid=KURL_APPID


// Error Message related constants
let KTITLE_NetworkError = "Network Error!"
let KMSG_CityList_failed = "Failed to fetch city list. "
let KMSG_NetworkError = "Please check your internet Connection and try again later.\n"
let KMSG_SelectCityAgain = "Select a city again to see the forecast."

// Messages related to empty data received
	// CityList
let  KMSG_PullToRefresh = "\n\nPlease swipe down to refresh the city list"
let  KMSG_CityList_NoData = "City list is not available now"
let  KMSG_CityList_Empty = "Received city list is Empty"
	// Forcast Detail
let KMSG_Forecast_Empty = "Received Forecast data is empty"
