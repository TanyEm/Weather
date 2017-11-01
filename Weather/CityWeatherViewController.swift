//
//  ViewController.swift
//  Weather
//
//  Created by Tanya Tomchuk on 22/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    
    var cityName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let weatherGetter = WeatherGetter()
        weatherGetter.getWeather(cityName: cityName, callback: {(result) -> () in
            print(result)
            DispatchQueue.main.async {
                self.city.text = result.name
                self.temp.text =  String(format: "%.2f°C", (result.main?.temp)!)
                self.tempMax.text = String(format: "Max: %.0f°C", (result.main?.temp_max)!)
                self.tempMin.text = String(format: "Min: %.0f°C", (result.main?.temp_min)!)
                if (result.weather.count > 0) {
                    self.status.text = result.weather[0]?.status
                } else {
                    self.status.text = ""
                }
            }
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "FullWeather") {
            let controller = segue.destination as! FullWeatherTableViewController
            controller.cityNameForMoreDay = self.cityName
            print(controller.cityNameForMoreDay)
        }
        
    }
}

