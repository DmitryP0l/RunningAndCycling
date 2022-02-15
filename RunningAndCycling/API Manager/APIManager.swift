//
//  APIManager.swift
//  RunningAndCycling
//
//  Created by lion on 6.02.22.
//

import Foundation
import Alamofire

struct APIManager {
    private static let apiKey = "9f80e6b624ba112e021f1e30ac273765"
    private static let getWeatherRequest = "https://api.openweathermap.org/data/2.5/onecall"
    
    static func getWeather(completion: @escaping(WeatherFullModel?) -> Void) {
        
        let parameters = [ "appid" : apiKey,
                           "units" : "metric",
                           "exclude" : "minutely",
                           "lat" : "53.9",
                           "lon" : "27.5667",
                           "lang" : "ru"]
        
        
        AF.request(getWeatherRequest, parameters: parameters).responseDecodable(of: WeatherResponse.self) { response in
            
            if let weather = response.value {

                guard let current = weather.current else { completion(nil); return }
                
                let currentWeather = WeatherModel(currentResponse: current)
                
                var hoursWeather: [WeatherModel] = []
                if let hourly = weather.hourly {
                    hoursWeather = hourly.compactMap({ WeatherModel(hourlyResponse: $0) })
                }
                let fullModel = WeatherFullModel(current: currentWeather, hourly: hoursWeather)
                
                completion(fullModel)
            } else {
                completion(nil)
            }
        }
    }
}
