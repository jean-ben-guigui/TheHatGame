//
//  Teams.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 12/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

class TimesUp {
    var teams:Teams
    var words:Words
    var phase:Phase
    
    init(_ teams:[Team]) {
        self.teams = Teams(teams)
        self.words = Words()
        self.phase = Phase()
    }
    
    convenience init(initWithData:Bool) {
        self.init([])
        if initWithData {
//            self.words = ["bien":wordState.notGuessed, "avron":wordState.notGuessed, "bibs":wordState.notGuessed, "fafLaMenace":wordState.notGuessed, "Choupie":wordState.notGuessed]
        }
    }
    
    ///return false if game is over
    func nextPhase() -> Bool {
        switch phase.state {
        case phaseState.first:
            phase.state = phaseState.second
            return true
        case phaseState.second:
            phase.state = phaseState.third
            return true
        default:
            return false
        }
    }
}
