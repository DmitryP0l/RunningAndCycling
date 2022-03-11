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

struct SpeedCellModel {
    let currentSpeed: String?
    let averageSpeed: String?
}
