//
//  Entity+AlecrimCoreDataAttributes.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import CoreData

import AlecrimCoreData


// MARK: - Entity query attributes

extension Entity {
    
    static let identifier = AlecrimCoreData.Attribute<String>("identifier")
    
}

// MARK: - AttributeProtocol extensions

extension AlecrimCoreData.AttributeProtocol where Self.ValueType: Entity {
    
    var identifier: AlecrimCoreData.Attribute<String> { return AlecrimCoreData.Attribute<String>("identifier", self) }
    
}

// MARK: - NSManagedObjectContext extensions

extension NSManagedObjectContext {
    
    var entities: AlecrimCoreData.Table<Entity> { return AlecrimCoreData.Table<Entity>(context: self) }
    
}
