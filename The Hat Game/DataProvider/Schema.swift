//
//  Schema.swift
//  The Hat Game
//
//  Created by Arthur Duver on 25/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//
// Select entities and attributes from the Core Data model.
//

import CoreData

/**
Relevant entities and attributes in the Core Data schema.
*/
enum Schema {
    enum WordSetEntity: String {
        case name
    }
    enum WordEntity: String {
        case data
    }
}
