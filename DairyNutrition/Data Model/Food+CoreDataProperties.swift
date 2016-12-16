//
//  Food+CoreDataProperties.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import CoreData

extension CoreFood {
    
    @NSManaged var identifier: String
    
    @NSManaged var date: String
    
    @NSManaged var name: String
    
    @NSManaged var quantity: Int16
    
    @NSManaged var nutrients: Set<CoreNutrient>
}

extension CoreFood {
    
    @objc(addNutrients:)
    @NSManaged func addToNutrients(_ values: Set<CoreNutrient>)
    
    @objc(removeNutrients:)
    @NSManaged func removeFromNutrients(_ values: Set<CoreNutrient>)
    
}
