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
    
    enum wordState {
        case notGuessed
        case guessed
    }
    
    enum phaseState {
        case first
        case second
        case third
    }
    
    var words:[String:wordState]
    var phase:phaseState
    
    init(_ teams:[Team]) {
        self.teams = teams
        self.words = [String:wordState]()
        self.phase = phaseState.first
    }
    
    convenience init(initWithData:Bool) {
        self.init([])
        if initWithData {
            self.words = ["bien":wordState.notGuessed, "avron":wordState.notGuessed, "bibs":wordState.notGuessed, "fafLaMenace":wordState.notGuessed, "Choupie":wordState.notGuessed]
        }
    }
}
