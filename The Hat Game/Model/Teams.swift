//
//  Teams.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 28/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

struct Teams {
    var list:Set<Team>
    var playingTeamId = 0
    
    init(_ teams:[Team]){
        self.list = Set(teams)
    }
    
    func getTeam(id:Int) -> Team? {
        guard let team = list.first(where: {
            $0.id == id
        }) else {
            return nil
        }
        return team
    }
    
    /// tries to add a team, returns true if team is added, return false if not.
    mutating func addTeam(name:String) throws {
        let count = list.count
        if count > 0 {
            let insert = list.insert(Team.init(name: name, id: count)).inserted
            if (!insert) {
                throw TeamsError.teamAlreadyInSet
            }
        } else {
            list.insert(Team.init(name: name, id: 0))
            return
        }
    }
    
    mutating func nextTeamPlaying() {
        if playingTeamId >= list.count - 1 {
            self.playingTeamId += 1
        } else {
            self.playingTeamId = 0
        }
    }
    
    func getTeamPlayingName() -> String? {
        if let playingTeam = getTeam(id: self.playingTeamId) {
            return playingTeam.name
        }
        return nil
    }
    
    mutating func addTeamScore(id: Int, score: Int) throws {
        guard var team = getTeam(id: id) else {
            throw TeamsError.noTeam(withId: id)
        }
        team.setScore(team.scorePreviousToCurrentPhase + score)
        let bien = self.list.update(with: team)
        if bien != nil {
            return
        } else {
            throw TeamsError.updateFailed
        }
    }
}
