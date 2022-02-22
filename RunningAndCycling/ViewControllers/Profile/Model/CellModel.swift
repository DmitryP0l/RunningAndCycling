//
//  ModelCellsProfile.swift
//  RunningAndCycling
//
//  Created by lion on 16.02.22.
//

import Foundation
import UIKit

enum ProfileCellType {
       case photo
       case name
       case statistics
       case achievements
   }

struct StatisticCellModel {
    let icon: String?
    let title: String?
    let result: String?
}

struct AchievementsCellModel {
    let icon: String?
    let title: String?
    let progressTitle: String?
    let progress: Int?
}


struct ProfileCellItem {
    let type: ProfileCellType // если делать опциональным, - case .none
    let dataModel: Any?
}

