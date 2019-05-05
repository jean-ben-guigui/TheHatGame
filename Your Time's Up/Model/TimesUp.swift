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
            self.words.addWord("johny be good")
            self.words.addWord("clude")
            self.words.addWord("humgreufab")
            self.words.addWord("javac")
            self.teams.addTeam(name: "commeMaxime")
            self.teams.addTeam(name: "wingFab")
            self.teams.addTeam(name: "choupie")
            self.phase.state = phaseState.first
        }
    }
    
    ///return false if game is over
    func nextPhase() -> Bool {
        self.words.resetAllWords()
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
