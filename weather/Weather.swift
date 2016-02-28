//
//  Weather.swift
//  weather
//
//  Created by ChangsoonJang on 2016. 2. 27..
//  Copyright © 2016년 All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Weather {
    
    private var _cityName: String!
    private var _shortWeatherDesc: String!
    private var _longWeatherDesc: String!
    private var _weatherIcon: String!
    private var _currentTemp: String!
    private var _minTemp: String!
    private var _maxTemp: String!
    private var _pressure: String!
    private var _humidity: String!
    private var _wind: String!
    
    private var _weatherURL: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var shortWeatherDesc: String {
        if _shortWeatherDesc == nil {
            _shortWeatherDesc = ""
        }
        return _shortWeatherDesc
    }
    
    var longWeatherDesc: String {
        if _longWeatherDesc == nil {
            _longWeatherDesc = ""
        }
        return _longWeatherDesc
    }
    
    var weatherIcon: String {
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    var minTemp: String {
        if _minTemp == nil {
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String {
        if _maxTemp == nil {
            _maxTemp = ""
        }
        return _maxTemp
    }
    
    var pressure: String {
        if _pressure == nil {
            _pressure = ""
        }
        return _pressure
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    var wind: String {
        if _wind == nil {
            _wind = ""
        }
        return _wind
    }
    
    init(city:String) {
        self._cityName = city
        
        
        self._weatherURL = "\(URL_BASE)\(self._cityName)\(API_KEY)"
    }
    
    func downloadWeatherDetails(completed:DownloadComplete) {
        let url = NSURL(string: _weatherURL)!
        
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                if let city = dict["name"] as? String {
                    self._cityName = city
                }
                
                if let weatherDetail = dict["weather"] as? [Dictionary<String,AnyObject>] where weatherDetail.count > 0 {
                    
                    if let shortDesc = weatherDetail[0]["main"] as? String {
                        self._shortWeatherDesc = shortDesc
                    }
                    if let longDesc = weatherDetail[0]["description"] as? String {
                        self._longWeatherDesc = longDesc
                    }
                    if let icon = weatherDetail[0]["icon"] as? String {
                        switch icon {
                        case "01d","01n":
                            self._weatherIcon = "*"
                        case "02d","02n":
                            self._weatherIcon = "3"
                        case "03d","03n":
                            self._weatherIcon = "a"
                        case "04d","04n":
                            self._weatherIcon = "1"
                        case "09d","09n":
                            self._weatherIcon = "b"
                        case "10d","10n":
                            self._weatherIcon = "h"
                        case "11d","11n":
                            self._weatherIcon = "p"
                        case "13d","13n":
                            self._weatherIcon = "N"
                        case "50d","50n" :
                            self._weatherIcon = "k"
                        default :
                            self._weatherIcon = "@"
                        }
                  
                    }

                }
                if let detail = dict["main"] as? Dictionary<String,AnyObject> {
                    if let temp = detail["temp"] as? Int {
                        self._currentTemp = "\(temp)°"
                    }
                    if let minTmp = detail["temp_min"] as? Int {
                        self._minTemp = "▼\(minTmp)°"
                    }
                    if let maxTmp = detail["temp_max"] as? Int {
                        self._maxTemp  = "▲\(maxTmp)°"
                    }
                    if let humid = detail["humidity"] as? Int {
                        self._humidity = "\(humid) %"
                    }
                    if let press = detail["pressure"] as? Int {
                        self._pressure = "\(press) hPa"
                    }
                }
                
                if let wnd = dict["wind"] as? Dictionary<String,AnyObject> {
                    if let speed = wnd["speed"] as? Double {
                        self._wind = "\(speed) m/s"
                    }
                }

            }
            completed()
          
        }

    }
    
    
    
    
    


    
    
    
    
    
    
    
    
    
}
