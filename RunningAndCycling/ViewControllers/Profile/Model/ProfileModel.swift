//
//  ProfileModel.swift
//  RunningAndCycling
//
//  Created by lion on 15.02.22.
//

import UIKit

struct ProfileModel {
    let photoImage: String
    let nameProfile: String
    let achievementsProfile: [AchievementModel]
}

struct AchievementModel {
    let image: UIImage
    let title: String
    let state: String
    let goal: String
}


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
    let type: ProfileCellType
    let dataModel: Any?
}

