//
//  Food.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import SwiftyJSON

@objc(Food)
class Food: NSObject, NSCoding {
    
    // MARK: Properties
    
    let name: String?
    let weight: Double?
    let measure: String?
    var nutrients: [Nutrient]?
    
    // MARK: Initial Functions
    
    public init(name: String,
        weight: Double,
        measure: String,
        nutrients: [Nutrient])
    {
        self.name = name
        self.weight = weight
        self.measure = measure
        self.nutrients = nutrients
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "foodName") as? String
        self.weight = aDecoder.decodeObject(forKey: "foodWeight") as? Double
        self.measure = aDecoder.decodeObject(forKey: "foodMeasure") as? String
        self.nutrients = aDecoder.decodeObject(forKey: "foodNutrients") as? [Nutrient]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "foodName")
        aCoder.encode(weight, forKey: "foodWeight")
        aCoder.encode(measure, forKey: "foodMeasure")
        aCoder.encode(nutrients, forKey: "foodNutrients")
    }
 
    public required init(fromJson json: AnyObject) {
        let json = JSON(json)
        
        self.name = json["report"]["foods"][0]["name"].stringValue
        self.weight = json["report"]["foods"][0]["weight"].doubleValue
        self.measure = json["report"]["foods"][0]["measure"].stringValue
        
        self.nutrients = [Nutrient]()
        
        if let nutrients = json["report"]["foods"][0]["nutrients"].array {
            for nutrient in nutrients {
                self.nutrients?.append(Nutrient(name: nutrient["nutrient"].stringValue,
                                                unit: nutrient["unit"].stringValue,
                                                value: nutrient["value"].stringValue,
                                                gm: nutrient["gm"].doubleValue)
                )
            }
        }
    }
    
}
