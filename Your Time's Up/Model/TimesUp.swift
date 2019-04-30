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
    var words:[String:wordState]
    var phase:Phase
    
    init(_ teams:[Team]) {
        self.teams = Teams(teams)
        self.words = [String:wordState]()
        self.phase = Phase()
    }
    
    convenience init(initWithData:Bool) {
        self.init([])
        if initWithData {
            self.words = ["bien":wordState.notGuessed, "avron":wordState.notGuessed, "bibs":wordState.notGuessed, "fafLaMenace":wordState.notGuessed, "Choupie":wordState.notGuessed]
        }
    }
    
    func setPlayingTeam(id:Int) {
        if self.phase.state == phaseState.none {
            print("WARNING, func setPlayingTeam - there shouldn't be a team playing in phase state phaseState.none")
        }
        teams.playingTeamId = id
    }
}
