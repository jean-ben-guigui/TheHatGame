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
    var scorePreviousToCurrentPhase:Int
    
    init(name:String) {
        self.name = name
        self.scorePreviousToCurrentPhase = 0
    }
}
