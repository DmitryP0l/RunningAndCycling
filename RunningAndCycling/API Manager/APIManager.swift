//
//  APIManager.swift
//  RunningAndCycling
//
//  Created by lion on 6.02.22.
//

import Foundation
import Alamofire

class WeatherModel {
    let temperature: String
    let fellsLikeTemperature: String
    let windSpeed: String
    let time: String
    let weatherDescription: String
    
    let windDirection: Int
    var windDirectionString: String {
        switch windDirection {
        case 348...360, 0...11:
            return "N"
        case 12...33:
            return "NNE"
        case 34...56:
            return "NE"
        case 57...78:
            return "ENE"
        case 79...101:
            return "E"
        case 102...123:
            return "ESE"
        case 124...146:
            return "SE"
        case 147...168:
            return "SSE"
        case 169...191:
            return "S"
        case 192...213:
            return "SSW"
        case 214...236:
            return "SW"
        case 237...258:
            return "WSW"
        case 259...281:
            return "W"
        case 282...303:
            return "WNW"
        case 304...326:
            return "NW"
        case 327...347:
            return "NNW"
        default:
            return "что-то пошло не так"
        }
    }
    // id image
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...504:
            return "cloud.rain.fill"
        case 511:
            return "cloud.sleet.fill"
        case 520...531:
            return "cloud.heavyrain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801:
            return "cloud.sun"
        case 802:
            return "cloud.sun.fill"
        case 803:
            return "cloud"
        case 804:
            return "cloud.fill"
        default:
            return "thermometer"
        }
    }
    
    init(currentResponse: Current) {
        
        var temperatureString = ""
        if let temp = currentResponse.temp {
            temperatureString = "\(Int(temp.rounded()))" + "°"
        }
        var fellsLikeTemperatureString = ""
        if let temp = currentResponse.feels_like {
            fellsLikeTemperatureString = "\(Int(temp.rounded()))" + "°"
        }
        var windSpeedString = ""
        if let wind = currentResponse.wind_speed {
            windSpeedString = "\(Int(wind.rounded()))" + "m/s"
        }
        
        self.temperature = temperatureString
        self.fellsLikeTemperature = fellsLikeTemperatureString
        self.windSpeed = windSpeedString
        self.windDirection = currentResponse.wind_deg ?? 361
        self.weatherDescription = currentResponse.weather?.first?.description ?? "нет данных"
        self.conditionCode = currentResponse.weather?.first?.id ?? 800
        self.time = ""
    }
    
    init(hourlyResponse: Hourly) {
        var temperatureString = ""
        if let temp = hourlyResponse.temp {
            temperatureString = "\(Int(temp.rounded()))" + "°"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        self.temperature = temperatureString
        self.conditionCode = hourlyResponse.weather?.first?.id ?? 800
        self.time = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(hourlyResponse.dt ?? 0)))
        self.fellsLikeTemperature = ""
        self.windSpeed = ""
        self.windDirection = 361
        self.weatherDescription = ""
    }
    
}


struct WeatherFullModel {
    let current: WeatherModel
    let hourly: [WeatherModel]
}

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
