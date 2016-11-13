//
//  UserDefaults+Key.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-12.
//  Copyright © 2016 Osiris. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    static let loggedIn = DefaultsKey<Bool?>("isLoggedIn")
    static let loggedUser = DefaultsKey<User?>("user")
}

extension UserDefaults {
    subscript(key: DefaultsKey<User?>) -> User? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
}
