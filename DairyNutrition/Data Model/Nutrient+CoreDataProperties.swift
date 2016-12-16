//
//  Nutrient+CoreDataProperties.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import CoreData

extension CoreNutrient {
    
    @NSManaged var identifier: String
    
    @NSManaged var name: String
    
    @NSManaged var unit: String
    
    @NSManaged var value: Double
    
    @NSManaged var food: CoreFood
}

