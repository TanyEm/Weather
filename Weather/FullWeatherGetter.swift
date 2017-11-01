//
//  FullWeatherGetter.swift
//  Weather
//
//  Created by Tanya Tomchuk on 31/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import Foundation



class FullWeatherGetter {

    private let openWeatherMapMoreDayBaseURL = "http://api.openweathermap.org/data/2.5/forecast?&units=metric&cnt=3"
    private let openWeatherMapMoreDayAPIKey = "20d7aafbf4827ce95ebe169620d1ad3b"
    
    func getWeather(cityNameForMoreDay: String, callback: @escaping (_ result: CityWeather)->() ) {
        
        // This is a pretty simple networking task, so the shared session will do.
        
        
        let weatherRequestMoreDayURL = ("\(openWeatherMapMoreDayBaseURL)&APPID=\(openWeatherMapMoreDayAPIKey)&q=\(cityNameForMoreDay)")

        guard let url = URL(string: weatherRequestMoreDayURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let fullWeatherCity = try JSONDecoder().decode(CityWeather.self, from: data)
                callback(fullWeatherCity)
            } catch let error {
                print(error)
            }
            }.resume()
    }
}
