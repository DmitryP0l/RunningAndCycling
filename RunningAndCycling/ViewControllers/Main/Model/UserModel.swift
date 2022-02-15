//
//  UserModel.swift
//  RunningAndCycling
//
//  Created by lion on 14.02.22.
//

import Foundation
import UIKit

struct UserModel {
    let userImage: UIImage?
    let achivements: String?
    
    init() {
        userImage = UIImage(systemName: "profile")
        achivements = "какой молодец"
    }
}
