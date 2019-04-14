//
//  Teams.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 12/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

class TimesUp {
    var teams:[Team]
    var words:[String:Int] //when associated with the value 0, it means that no teams guessed that word during that phase yet.
    var phase:Int
    
    init(_ teams:[Team]) {
        self.teams = teams
        self.words = [String:Int]()
        self.phase = 1
    }
    
    convenience init(initWithData:Bool) {
        self.init([])
        if initWithData {
            self.words = ["bien":0, "avron":0, "bibs":0, "fafLaMenace":0, "Choupie":0]
        }
    }
}
