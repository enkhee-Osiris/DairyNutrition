//
//  Nutrient+ AlecrimCoreDataAttributes.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

// MARK: - AlarmType query attributes

extension CoreNutrient {
    
    static let name = AlecrimCoreData.Attribute<String>("name")
    
    static let unit = AlecrimCoreData.Attribute<String>("name")
    
    static let value = AlecrimCoreData.Attribute<Double>("value")
    
    static let food = AlecrimCoreData.Attribute<CoreFood>("food")
}

// MARK: - AttributeProtocol extensions

extension AlecrimCoreData.AttributeProtocol where Self.ValueType: CoreNutrient {
    
    var name: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("name", self) }
    
    var unit: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("unit", self) }
    
    var value: AlecrimCoreData.Attribute<Double> { return AlecrimCoreData.Attribute<Double>("value", self) }
    
    var food: AlecrimCoreData.Attribute<CoreFood> { return AlecrimCoreData.Attribute<CoreFood>("food", self) }
}

// MARK: - NSManagedObjectContext extensions

extension NSManagedObjectContext {
    
    var nutrients: AlecrimCoreData.Table<CoreNutrient> { return AlecrimCoreData.Table<CoreNutrient>(context: self) }
    
}
