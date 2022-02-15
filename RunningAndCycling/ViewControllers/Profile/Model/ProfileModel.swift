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
