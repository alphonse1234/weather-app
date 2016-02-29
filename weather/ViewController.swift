//
//  ViewController.swift
//  weather
//
//  Created by ChangsoonJang on 2016. 2. 27..
//  Copyright © 2016년 All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var shortWeatherDesc: UILabel!
    @IBOutlet var longWeatherDesc: UILabel!
    @IBOutlet var weatherIcon: UILabel!
    @IBOutlet var currentTemp: UILabel!
    @IBOutlet var minTemp: UILabel!
    @IBOutlet var maxTemp: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var wind: UILabel!
    @IBOutlet var frontView: UIView!
    
    var searchInput: String!
    var weather: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        weather = Weather(city:"Seoul")
        
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
            self.frontView.hidden = true
        }

    }

    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchInput = searchBar.text!
        weather = Weather(city: searchInput)
        searchBar.text = ""
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
        }
        
        if self.weather.url == nil {
            let alert = UIAlertController(title: "Error", message: "Could not find '\(searchInput)'", preferredStyle: .Alert)
            
            let ok = UIAlertAction(title: "Try again", style: .Cancel){ (UIAlertAction) -> Void in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
            
            }
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        searchBar.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    


    func updateUI() {
        cityName.text = weather.cityName.uppercaseString
        shortWeatherDesc.text = weather.shortWeatherDesc.uppercaseString
        longWeatherDesc.text = weather.longWeatherDesc.uppercaseString
        weatherIcon.text = weather.weatherIcon
        currentTemp.text = weather.currentTemp
        minTemp.text = weather.minTemp
        maxTemp.text = weather.maxTemp
        pressure.text = weather.pressure.capitalizedString
        humidity.text = weather.humidity
        wind.text = weather.wind
        self.changWeatherIconColor()
    }

    
    func changWeatherIconColor() {
        switch weatherIcon.text! {
        case "*":
            weatherIcon.textColor = UIColor(red: 254 / 255, green: 229 / 255 , blue: 41 / 255, alpha: 1.0 )
        case "3":
            weatherIcon.textColor = UIColor(red: 50 / 255, green: 148 / 255 , blue: 212 / 255, alpha: 1.0 )
        case "a":
            weatherIcon.textColor = UIColor(red: 50 / 255, green: 148 / 255 , blue: 212 / 255, alpha: 1.0 )
        case "1":
            weatherIcon.textColor = UIColor(red: 50 / 255, green: 148 / 255 , blue: 212 / 255, alpha: 1.0 )
        case "b":
            weatherIcon.textColor = UIColor(red: 50 / 255, green: 148 / 255 , blue: 212 / 255, alpha: 1.0 )
        case "h":
            weatherIcon.textColor = UIColor(red: 50 / 255, green: 148 / 255 , blue: 212 / 255, alpha: 1.0 )
        case "p":
            weatherIcon.textColor = UIColor(red: 50 / 255, green: 148 / 255 , blue: 212 / 255, alpha: 1.0 )
        case "N":
            weatherIcon.textColor = UIColor(red: 50 / 255, green: 148 / 255 , blue: 212 / 255, alpha: 1.0 )
        case "k":
            weatherIcon.textColor = UIColor(red: 25 / 255, green: 43 / 255 , blue: 135 / 255, alpha: 1.0 )
        default :
            weatherIcon.textColor = UIColor.blackColor()
        }
    }
}

