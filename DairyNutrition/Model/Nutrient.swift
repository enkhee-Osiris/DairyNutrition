//
//  Nutrient.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation

@objc(Nutrient)
class Nutrient: NSObject, NSCoding {
    
    // MARK: Properties
    
    let name: String?
    let unit: String?
    let value: String?
    let gm: Double?
    
    // MARK: Initial Functions
    
    public init(name: String,
        unit: String,
        value: String,
        gm: Double)
    {
        self.name = name
        self.unit = unit
        self.value = value
        self.gm = gm
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "nutrientName") as? String
        self.unit = aDecoder.decodeObject(forKey: "nutrientUnit") as? String
        self.value = aDecoder.decodeObject(forKey: "nutrientValue") as? String
        self.gm = aDecoder.decodeObject(forKey: "nutrientGm") as? Double
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "nutrientName")
        aCoder.encode(unit, forKey: "nutrientUnit")
        aCoder.encode(value, forKey: "nutrientValue")
        aCoder.encode(gm, forKey: "nutrientGm")
    }
    
}
