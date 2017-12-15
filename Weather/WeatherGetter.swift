//
//  WeatherGetter.swift
//  Weather
//
//  Created by Tanya Tomchuk on 22/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import Foundation
import CoreData

struct CityWeather: Decodable {
    var weather: [Weather?]
    var name: String?
    var main: MainInfo?
    init() {
        weather = [Weather]()
        name = ""
        main = MainInfo()
    }
}

struct Weather: Decodable {
    var status: String?
    enum CodingKeys : String, CodingKey {
        case status = "main"
    }
    init() {
        status = ""
    }
}

struct MainInfo: Decodable {
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
    
    init() {
        temp = 0.0
        temp_min = 0.0
        temp_max = 0.0
    }
}

class WeatherGetter {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather?&units=metric&"
    private let openWeatherMapAPIKey = "20d7aafbf4827ce95ebe169620d1ad3b"
    
    func getWeather(cityName: String, callback: @escaping (_ result: CityWeather)->() ) {
        
        // This is a pretty simple networking task, so the shared session will do.
        
        let weatherRequestURL = ("\(openWeatherMapBaseURL)APPID=\(openWeatherMapAPIKey)&q=\(cityName)")
        
        guard let url = URL(string: weatherRequestURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let weatherCity = try JSONDecoder().decode(CityWeather.self, from: data)
                callback(weatherCity)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
