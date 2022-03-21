//
//  RunningModel.swift
//  RunningAndCycling
//
//  Created by lion on 21.02.22.
//

import Foundation

enum RunningCellType {
       case timer
       case distabce
       case speed
   }

struct RunningCellItem {
    let type: RunningCellType
    let dataModel: Any?
}

struct TimerCellModel {
    var currentTimer: String?
    let setTimer: String?
    let leftAllTimer: String?
    let setInterval: String?
    let leftInterval: String?
}

struct DistancionCellModel {
    let currentDistancion: String?
    let setDistance: String?
    let leftDistance: String?
}

struct SpeedCellModel {
    let currentSpeed: String?
    let averageSpeed: String?
}

struct SavedTraning: Codable {
    let date: Date
    let time: Int
    let distance: Double
}
