//
//  User.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-09.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

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

@objc(User)
class User: NSObject, NSCoding {
    
    // MARK: Properties
    
    let fullName: String?
    let email: String?
    
    let weightGoalType: UserWeightGoal?
    let weightGoal: Double?
    let weightGoalUnit: UserWeightUnit?
    
    let gender: UserGender?
    let activityLevel: UserActivityLevel?
    
    let weight: Double?
    let weightUnit: UserWeightUnit?
    
    let height: String?
    let heightUnit: UserHeightUnit?
    
    // Date of Birth
    let dob: String?
    
    // MARK: - Initial functions
    
    public init(fullName: String,
        email: String,
        weightGoalType: UserWeightGoal,
        weightGoal: Double,
        weightGoalUnit: UserWeightUnit,
        gender: UserGender,
        activityLevel: UserActivityLevel,
        weight: Double,
        weightUnit: UserWeightUnit,
        height: String,
        heightUnit: UserHeightUnit,
        dateOfBirth: String)
    {
        self.fullName = fullName
        self.email = email
        self.weightGoalType = weightGoalType
        self.weightGoal = weightGoal
        self.weightGoalUnit = weightGoalUnit
        self.gender = gender
        self.activityLevel = activityLevel
        self.weight = weight
        self.weightUnit = weightUnit
        self.height = height
        self.heightUnit = heightUnit
        self.dob = dateOfBirth
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.fullName = aDecoder.decodeObject(forKey: "fullName") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        
        self.weightGoalType =  UserWeightGoal(rawValue: (aDecoder.decodeObject(forKey: "weightGoalType") as! Int))
        self.weightGoal = aDecoder.decodeObject(forKey: "weightGoal") as? Double
        self.weightGoalUnit =  UserWeightUnit(rawValue: (aDecoder.decodeObject(forKey: "weightGoalUnit") as! Int))
        
        self.gender =  UserGender(rawValue: aDecoder.decodeObject(forKey: "gender") as! Int)
        
        self.activityLevel =  UserActivityLevel(rawValue: aDecoder.decodeObject(forKey: "activityLevel") as! Int)
        
        self.weight = aDecoder.decodeObject(forKey: "weight") as? Double
        self.weightUnit = UserWeightUnit(rawValue: aDecoder.decodeObject(forKey: "weightUnit") as! Int)
        
        self.height = aDecoder.decodeObject(forKey: "height") as? String
        self.heightUnit = UserHeightUnit(rawValue: aDecoder.decodeObject(forKey: "heightUnit") as! Int)
        self.dob = aDecoder.decodeObject(forKey: "dateOfBirth") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        print("Encoding")
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(email, forKey: "email")
        
        aCoder.encode(weightGoalType?.rawValue, forKey: "weightGoalType")
        aCoder.encode(weightGoal, forKey: "weightGoal")
        aCoder.encode(weightGoalUnit?.rawValue, forKey: "weightGoalUnit")
        
        aCoder.encode(gender?.rawValue, forKey: "gender")
        
        aCoder.encode(activityLevel?.rawValue, forKey: "activityLevel")
        
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(weightUnit?.rawValue, forKey: "weightUnit")
        
        aCoder.encode(height, forKey: "height")
        aCoder.encode(heightUnit?.rawValue, forKey: "heightUnit")
        
        aCoder.encode(dob, forKey: "dateOfBirth")
    }
    
    public required init(fromJson json: AnyObject) {
        
        let json = JSON(json)
        
        self.fullName = "\(json["user"]["firstname"].stringValue) \(json["user"]["lastname"].stringValue)"
        self.email = json["user"]["email"].stringValue
        self.weightGoalType = UserWeightGoal(rawValue: json["user"]["weightGoalType"].intValue)
        self.weightGoal = json["user"]["weightGoal"].doubleValue
        self.weightGoalUnit = UserWeightUnit(rawValue: json["user"]["weightGoalUnit"].intValue)
        self.gender = UserGender(rawValue: json["user"]["gender"].intValue)
        self.activityLevel = UserActivityLevel(rawValue: json["user"]["activityLevel"].intValue)
        self.weight = json["user"]["weight"].doubleValue
        self.weightUnit = UserWeightUnit(rawValue: json["user"]["weightUnit"].intValue)
        self.height = json["user"]["height"].stringValue
        self.heightUnit = UserHeightUnit(rawValue: json["user"]["heightUnit"].intValue)
        self.dob = json["user"]["dateOfBirth"].stringValue
    }
}
