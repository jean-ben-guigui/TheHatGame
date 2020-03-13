//
//  Team.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 12/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

struct Team: Hashable {
    var id:Int
    var name:String
    var scorePreviousToCurrentPhase:Int
    var playing:Bool
    
    init(name:String, id:Int) {
        self.name = name
        self.id = id
        self.scorePreviousToCurrentPhase = 0
        self.playing = false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
