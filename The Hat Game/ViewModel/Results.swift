//
//  ResultViewControllerViewModel.swift
//  The Hat Game
//
//  Created by Arthur Duver on 20/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct Results {
    var hatGame: HatGame
    
    let rankValues = ["1st","2nd","3rd","4th"]
    
    func getTeamRanks() throws -> [TeamRank] {
        let teams = try hatGame.getTeamSortedByScores()
        var teamRanks = [TeamRank]()
        var currentRank = 0
        var currentScore = -1
        let teamScores = teams.map { $0.scorePreviousToCurrentPhase }
        for (index, score) in teamScores.enumerated() {
            if score == currentScore {
                teamRanks.append(TeamRank(team: teams[index], rank: rankValues[currentRank]))
            } else {
                currentRank = index
                currentScore = score
                teamRanks.append(TeamRank(team: teams[index], rank: rankValues[currentRank]))
            }
        }
        return teamRanks
    }
}

