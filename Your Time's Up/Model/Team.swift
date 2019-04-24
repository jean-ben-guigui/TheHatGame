//
//  Team.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 12/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

class Team {
    var name:String
    var id:Int
    var scorePreviousToCurrentPhase:Int
    
    init(name:String, id:Int) {
        self.name = name
        self.id = id
        self.scorePreviousToCurrentPhase = 0
    }
}
