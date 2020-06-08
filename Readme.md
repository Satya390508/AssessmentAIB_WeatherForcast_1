# 5 Day Weather Forecast 

This is a native iOS Application written in Swift for the internal Wipro code assessment.
This Application uses **OpenWeatherMap 5 day weather forecast APIs** to retrive and process data for the application.



## Overview

This Application uses the [OpenWeatherMap's Bulk downloading API](https://bulk.openweathermap.org/sample/city.list.json.gz) to fetch city list and arranges them in a table view.
Based on user input, this will fetch the weather forecast details for selected city using the CityID.

Example:-  [5 day weather forecast API with CityID](https://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=439d4b804bc8187953eb36d2a8c26a02)

Application is using Swift Codable to process the JSON data provided by above APIs

Application is using very basic UI layout to represent the data received and parsed.

At present, this application does not contain any test cases

### Dependencies
CocoaPods has been used to integrate 3rd party SDKs to acheieve following features, -
1. [GzipSwift](https://github.com/qyhongfan/gzipswift) has been used to decompress the data received from the city list API
2. [ReachabilitySwift](https://github.com/ashleymills/Reachability.swift) has been used to check network connectivity
3. [JGProgressHUD](https://github.com/JonasGessner/JGProgressHUD) has been used to provide the loading hud to update the user about the status of web service call



## How to Build & Run the code base

Steps to follow to build the code in Xcode, -
1. Clone or download the project 
2. Open the folder named as "AssessmentAIB_WeatherForcast_1"
3. Find the file with extension".xcworkspace" and Double click to open in Xcode

To run the app on simulator, -
1. Alternative1 :  `Xcode > Toolbar > Scheme > choose any iPhone simulator > click on "Run button"`
2. Alternative2 :  `Xcode > Toolbar > Scheme > choose any iPhone simulator > press Command-R (⌘R)`
3. Alternative3 :  `Xcode > Toolbar > Scheme > choose any iPhone simulator > Xcode Menus > Product > Run`

[comment]: # "For resized image, to reduce size of image"
<img src="https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_schememenu_2x.png" alt="" width="600" height="300">

[comment]: # "For Original image"
![Run Button](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_toolbar_2x.png)
<center><font size="0.05"><em>Images referred from developer.apple.com</em></font></center>



## How to use the application
Once the application is running on the simulator, - 
- Swipe down to use the _Pull to refresh_ feature to fetch the city list from server
- Once city list is populated with city name and geo loactions, select any city to see the forecast details
- If forecast data is received successfully, then application will present another view on top of the city list for weather forecast details with a basic layout with only numbers
- User can close this detail view by clicking the close button at top left corner of the scrren and go back to city list to select another city


## Future Enhancement

This Application can be further enhanced to
1. Beautify the app using better UI layouts fashioned with the icons available from above API provider
2. Provide feature for user to see the forecasting by selecting from list layout or entering to text lyaouts, - 
	- City Name
	- Geo Location
	- Zip/Pin code
3. Provide search feature so that user can immediatley find the city s/he is looking for to see the forecast details
4. Provide support for multiple Units format for temperature such as °K, °F, °C, etc.
5. Provide multilingual support
6. Add testcases based on the features
