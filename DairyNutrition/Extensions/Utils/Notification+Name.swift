//
//  Notification+Name.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-12.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let signInNextButtonWillEnable = Notification.Name("signInNextButtonWillEnable")
    static let signInNextButtonWillDisable = Notification.Name("signInNextButtonWillDisable")
    static let noNetworkConnection = Notification.Name("noNetworkConnection")
    
    static let pushFoodDairy = Notification.Name("pushFoodDairy")
    static let pushExerciseDairy = Notification.Name("pushExerciseDairy")
    static let pushWeightTracker = Notification.Name("pushWeightTracker")
    static let pushSettings = Notification.Name("pushSettings")
}
