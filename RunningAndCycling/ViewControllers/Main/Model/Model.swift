//
//  UserModel.swift
//  RunningAndCycling
//
//  Created by lion on 14.02.22.
//

import Foundation
import UIKit


enum MainCellType {
    case currentWeather(day: WeatherModel)
    case hourly(hours: [WeatherModel])
    case latest(latest: LatestCellModel)
}

struct LatestCellModel {
    let date: String?
    let time: String?
    let speed: String?
    let distance: String?
}
