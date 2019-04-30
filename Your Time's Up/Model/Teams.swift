//
//  Teams.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 28/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

class Teams {
    var list:[Team]
    var playingTeamId:Int?
    
    init(_ teams:[Team]){
        self.list = teams
        sortTeams()
    }
    
    func getTeam(id:Int) -> Team? {
        for team in self.list {
            if team.id == id {
                return team
            }
        }
        return nil
    }
    
    func addTeam(name:String) {
        sortTeams()
        if let lastListItem = list.last {
            self.list.append(Team.init(name: name, id: lastListItem.id + 1))
        } else {
             self.list.append(Team.init(name: name, id: 0))
        }
    }
    
    private func sortTeams() {
       list.sort {
            $0.id < $1.id
        }
    }
    
    func nextTeamPlaying() {
        if !self.list.isEmpty {
            if let nnPlayingTeamId = playingTeamId {
                if let playingTeamIndex = getTeamIndex(id: nnPlayingTeamId) {
                    let nextPlayingTeamIndex = playingTeamIndex == self.list.count ? 0 : playingTeamIndex + 1
                    self.playingTeamId = self.list[nextPlayingTeamIndex].id
                }
            } else {
                if !self.list.isEmpty {
                    self.playingTeamId = self.list[0].id
                } else {
                    print("ERROR - nextTeamPlaying - no team in list")
                }
            }
        }
    }
    
    private func getTeamIndex(id:Int) -> Int? {
        var index = 0
        for team in self.list {
            if team.id == id {
                return index
            }
            index += 1
        }
        return nil
    }
//
//    private func findHighestTeamId() -> Int? {
//        if self.teams.count == 0 {
//            return nil
//        } else {
//            var HighestTeamId = 0
//            for team in self.teams {
//                if team.id > HighestTeamId {
//                    HighestTeamId = team.id
//                }
//            }
//            return HighestTeamId
//        }
//    }
}
