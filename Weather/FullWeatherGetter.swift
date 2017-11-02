//
//  FullWeatherGetter.swift
//  Weather
//
//  Created by Tanya Tomchuk on 31/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import Foundation

struct IncomingData: Decodable {
    var list: [FullCityWeather?]
    init() {
        list = [FullCityWeather]()
    }
}

struct FullCityWeather: Decodable {
    var dt: Int
    var weather: [FullWeather?]
    var main: FullMainInfo?
    var dt_txt: String
    init() {
        dt = 0
        weather = [FullWeather]()
        dt_txt = ""
        main = FullMainInfo()
    }
}

struct FullWeather: Decodable {
    var status: String?
    enum CodingKeys : String, CodingKey {
        case status = "main"
    }
    init() {
        status = ""
    }
}

struct FullMainInfo: Decodable {
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
    
    init() {
        temp = 0.0
        temp_min = 0.0
        temp_max = 0.0
    }
}

class FullWeatherGetter {

    private let openWeatherMapMoreDayBaseURL = "http://api.openweathermap.org/data/2.5/forecast?&units=metric&cnt=24"
    private let openWeatherMapMoreDayAPIKey = "20d7aafbf4827ce95ebe169620d1ad3b"
    
    func fullGetWeather(cityNameForMoreDay: String, callback: @escaping (_ result: IncomingData)->() ) {
        
        // This is a pretty simple networking task, so the shared session will do.
        
        
        let weatherRequestMoreDayURL = ("\(openWeatherMapMoreDayBaseURL)&APPID=\(openWeatherMapMoreDayAPIKey)&q=\(cityNameForMoreDay)")

        guard let url = URL(string: weatherRequestMoreDayURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                var fullWeatherCity = try JSONDecoder().decode(IncomingData.self, from: data)
                fullWeatherCity.list = self.joinByDay(weatherList: fullWeatherCity.list as! [FullCityWeather])
                callback(fullWeatherCity)
            } catch let error {
                print(error)
            }
            }.resume()
    }
    
    func joinByDay(weatherList: [FullCityWeather]) -> [FullCityWeather] {
        var prevDate = Date()
        var cnt = 1.0
        var weatherDailyList = [FullCityWeather]()
        var weatherDailyItem = FullCityWeather()
        var isFirst = true
        for weatherItem in weatherList {
            if isFirst {
                weatherDailyItem = weatherItem
                isFirst = false
                continue
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
                
            cnt += 1
            weatherDailyItem.dt = weatherItem.dt
            weatherDailyItem.dt_txt = dateFormatter.string(from: prevDate)
            weatherDailyItem.weather = weatherItem.weather
            weatherDailyItem.main?.temp! += (weatherItem.main?.temp)!
            
            if (weatherDailyItem.main?.temp_max)! < (weatherItem.main?.temp_max)! {
               weatherDailyItem.main?.temp_max! = (weatherItem.main?.temp_max)!
            }
            
            if (weatherDailyItem.main?.temp_min)! > (weatherItem.main?.temp_min)! {
                weatherDailyItem.main?.temp_min! = (weatherItem.main?.temp_min)!
            }
            
            var currDate = prevDate
            currDate.addTimeInterval(TimeInterval(weatherItem.dt - Int(prevDate.timeIntervalSince1970)))
            
            if dateFormatter.string(from: prevDate) != dateFormatter.string(from: currDate) {
                
                var fullMainInfo = FullMainInfo()
                fullMainInfo = weatherDailyItem.main!
                fullMainInfo.temp = ((weatherDailyItem.main?.temp)! / cnt)
                
                weatherDailyItem.main = fullMainInfo
                weatherDailyList.append(weatherDailyItem)
                cnt = 1.0
                weatherDailyItem = weatherItem
                
            }
            
            prevDate = currDate
        }
        return weatherDailyList
    }
}
