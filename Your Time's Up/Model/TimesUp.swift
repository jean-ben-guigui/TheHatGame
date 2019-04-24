//
//  Teams.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 12/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

enum phaseState {
    case first
    case second
    case third
}


class TimesUp {
    var teams:[Team]
    
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
    
    func getTeam(id:Int) -> Team? {
        for team in self.teams {
            if team.id == id {
                return team
            }
        }
        return nil
    }
}
