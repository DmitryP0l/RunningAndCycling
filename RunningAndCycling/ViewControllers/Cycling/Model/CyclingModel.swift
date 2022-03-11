//
//  CyclingModel.swift
//  RunningAndCycling
//
//  Created by lion on 22.02.22.
//

import Foundation

enum CyclingCellType {
    case map
    case parameters
}

struct cyclingCellItem {
    let type: CyclingCellType
    let dataModel: Any?
}

struct ParametersCellModel {
    let currentSpeed: String?
    let averageSpeed: String?
    let distance: String?
    let basicTimer: String?
}
