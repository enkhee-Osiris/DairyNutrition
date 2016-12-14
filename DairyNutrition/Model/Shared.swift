//
//  Shared.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-09.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

final class Shared {
    static let shared = Shared()
    
    var currentUser : User!
    var isLoggedIn: Bool!
    
    var selectedDate: Date!
}
