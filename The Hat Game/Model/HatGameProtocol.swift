//
//  File.swift
//  The Hat Game
//
//  Created by Arthur Duver on 18/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

protocol HatGameProtocol {
    var teams:Set<Team> {get set}
    var playingTeamId:Int {get set}
    var wordSet:WordSet {get set}
    var phase:Phase {get set}
    
    /// Return false if game is over
    func nextPhase() -> Bool
    
    //
    // MARK: - Teams
    //
    func getTeam(id:Int) throws -> Team
    
    /// Tries to add a team, returns true if team is added, return false if not.
    func addTeam(name:String) throws
    
    func nextTeamPlaying()
    
    func getTeamPlayingName() throws -> String
    
    func addTeamScore(id: Int, score: Int) throws
    
    // MARK: - WordSet
    func wordCount() -> Int
    
    func addWordToWordSet(_ word: String) throws -> Word
    
    func setGuessedWord(_ word: Word, teamId: Int)
}
