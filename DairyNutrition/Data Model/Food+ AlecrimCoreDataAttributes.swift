//
//  Food+ AlecrimCoreDataAttributes.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

// MARK: - AlarmType query attributes

extension CoreFood {
    
    static let identifier = AlecrimCoreData.Attribute<String>("identifier")
    
    static let date =  AlecrimCoreData.Attribute<String>("date")

    static let name = AlecrimCoreData.Attribute<String>("name")
    
    static let quantity = AlecrimCoreData.Attribute<Int16>("quantity")
    
    static let nutrients = AlecrimCoreData.Attribute<Set<CoreNutrient>>("nutrients")
    
}

// MARK: - AttributeProtocol extensions

extension AlecrimCoreData.AttributeProtocol where Self.ValueType: CoreFood {
    
    var identifier: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("identifier", self) }
    
    var date: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("date", self) }
    
    var name: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("name", self) }
    
    var quantity: AlecrimCoreData.Attribute<Int16> { return AlecrimCoreData.Attribute<Int16>("quantity", self) }
    
    var nutrients: AlecrimCoreData.Attribute<Set<CoreNutrient>> { return AlecrimCoreData.Attribute<Set<CoreNutrient>>("nutrients", self) }
}

// MARK: - NSManagedObjectContext extensions

extension NSManagedObjectContext {
    
    var foods: AlecrimCoreData.Table<CoreFood> { return AlecrimCoreData.Table<CoreFood>(context: self) }
    
}
