//
//  User.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-09.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import UIKit

enum UserWeightGoal: Int {
    case weightGain, maintain, weightLoss
}

enum UserActivityLevel: Int {
    case sedentary, lowActive, active, veryActive
}

enum UserWeightUnit: Int {
    case kg, lb
}

enum UserHeightUnit: Int {
    case cm, inch
}
enum UserGender: Int {
    case male, female
}

class User {
    var fullName: String? = "Guest"
    var email: String?
    
    var weightGoalType: UserWeightGoal?
    var weightGoal: Double? = 0
    var weightGoalUnit: UserWeightUnit?
    
    var gender: UserGender?
    var activityLevel: UserActivityLevel?
    
    var weight: Double?
    var weightUnit: UserWeightUnit?
    
    var height: String?
    var heighttUnit: UserHeightUnit?
    
//    init(lastName: String, firstName: String, isMale: Bool, weight: Double, weigthGoalType: UserWeightGoal, weightGoal: Double,weightUnit: UserWeightUnit, height: String, heightUnit: UserHeightUnit) {
//        self.fullName = lastName + " " + firstName
//        self.isMale = isMale
//        
//        self.weightGoal = weightGoal
//        self.weightGoalType = weigthGoalType
//        
//        self.weight = weight
//        self.weightUnit = weightUnit
//        
//        self.height = height
//        self.heighttUnit = heightUnit
//        
//    }
    
    init() {}
    
    init(dictionary: [String : AnyObject]) {
        // Note: This is a naive implementation of JSON parsing.
        // In a production Swift app, we recommend using a library such as Decodable: https://github.com/Anviking/Decodable
        
//        self.fullName = lastName + " " + firstName
//        self.isMale = isMale
//        
//        self.weightGoal = weightGoal
//        self.weightGoalType = weigthGoalType
//        
//        self.weight = weight
//        self.weightUnit = weightUnit
//        
//        self.height = height
//        self.heighttUnit = heightUnit
//        
//        id = dictionary["id"] as! Int
//        collectionPermalink = permalink
//        name = (dictionary["name"] as! String).trimmingCharacters(in: CharacterSet.whitespaces)
//        description = (dictionary["description"] as! String).trimmingCharacters(in: CharacterSet.whitespaces)
//        price = (dictionary["price"] as! NSString).floatValue
//        retailPrice = (dictionary["retail_price"] as! NSString).floatValue
//        if let _ = dictionary["percentoff"] as? Int {
//            percentOff = dictionary["percentoff"] as! Int
//        } else {
//            percentOff = 0
//        }
//        currency = "USD"
//        productURL = URL(string: (dictionary["url"] as! String!))!
//        
//        // Save the image URL and make sure it is HTTPS.
//        var imageURLComponents = URLComponents(string: dictionary["image_url"] as! String)!
//        imageURLComponents.scheme = "https"
//        imageURL = imageURLComponents.url!
    }
    
}
