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
        for team in self.list {
            if team.id == id {
                return team
            }
        }
        return nil
    }
    
    /// tries to add a team, returns true if team is added, return false if not.
    mutating func addTeam(name:String) -> Bool {
        let count = list.count
        if(count > 0) {
            return list.insert(Team.init(name: name, id: count + 1)).inserted
        } else {
            list.insert(Team.init(name: name, id: 0))
            return true
        }
    }
    
    mutating func nextTeamPlaying() {
        guard self.list.count > 1 else {
            // should throw
            print("ERROR - nextTeamPlaying - not enough team in list")
            return
        }
        self.playingTeamId += 1
    }
    
    func getTeamPlayingName() -> String? {
        if let playingTeam = getTeam(id: self.playingTeamId) {
            return playingTeam.name
        }
        return nil
    }
}
