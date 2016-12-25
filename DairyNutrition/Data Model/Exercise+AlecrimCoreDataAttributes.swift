//
//  Exercise+AlecrimCoreDataAttributes.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-25.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

// MARK: - AlarmType query attributes

extension CoreExercise {
    
    static let identifier = AlecrimCoreData.Attribute<String>("identifier")
    
    static let date = AlecrimCoreData.Attribute<String>("date")
    
    static let name = AlecrimCoreData.Attribute<String>("name")
    
    static let value = AlecrimCoreData.Attribute<Int16>("value")
}

// MARK: - AttributeProtocol extensions

extension AlecrimCoreData.AttributeProtocol where Self.ValueType: CoreExercise {

    var identifier: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("identifier", self) }
    
    var date: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("date", self) }
    
    var name: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("name", self) }
    
    var value: AlecrimCoreData.Attribute<Int16> { return AlecrimCoreData.Attribute<Int16>("value", self) }

}

// MARK: - NSManagedObjectContext extensions

extension NSManagedObjectContext {
    
    var exercises: AlecrimCoreData.Table<CoreExercise> { return AlecrimCoreData.Table<CoreExercise>(context: self) }
    
}
