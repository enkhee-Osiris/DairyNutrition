//
//  Exercise+CoreDataProperties.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-25.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import CoreData

extension CoreExercise {
    
    @NSManaged var identifier: String
    
    @NSManaged var date: String
    
    @NSManaged var name: String
    
    @NSManaged var value: Int16
}
