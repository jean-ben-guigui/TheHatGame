//
//  Teams.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 12/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

class HatGame {
    private(set) var teams:Set<Team>
    private(set) var playingTeamId = 0
    private(set) var wordSet:WordSet
    private(set) var phase:Phase
    
    init(_ teams:[Team]) {
        self.teams = Set(teams)
        self.wordSet = WordSet()
        self.phase = Phase()
        self.phase.state = 1
    }
    
    convenience init(data:Bool, result: Bool) {
        self.init([])
        if data {
            do {
                try wordSet.addWord("johny be good")
                try wordSet.addWord("clude")
                try wordSet.addWord("humgreufab")
                try wordSet.addWord("javac")
                try addTeam(name: "commeMaxime")
                try addTeam(name: "wingFab")
                try addTeam(name: "choupie")
            } catch {
                return
            }
            self.phase.state = 1
        }
        if result {
            do {
                try addTeamScore(id: 0, score: 5)
                try addTeamScore(id: 1, score: 12)
                try addTeamScore(id: 2, score: 12)
            } catch {
                return
            }
        }
    }
    
    /// Return false if game is over
    func nextPhase() -> Bool {
        // TODO
        for word in self.wordSet.words {
            switch word.state{
            case .notGuessed :
                fatalError("There is a word that is not guessed, therefore we shouldn't pass here")
            case .guessed(let id) :
                do {
                    try addTeamScore(id: id, score: 1)
                }
                catch {
                    fatalError("A team id is invalid: \(id)")
                }
            }
        }
        wordSet.resetAllWords()
        if phase.state < 3 {
            phase.state += 1
            return true
        }
        else {
            return false
        }
    }
    
    //
    // MARK: - Teams
    //
    func getTeam(id:Int) throws -> Team  {
        guard let team = teams.first(where: {
            $0.id == id
        }) else {
            throw TeamsError.noTeam(withId: id)
        }
        return team
    }
    
    func getTeamScorePreviousToCurrentPhase(id: Int) throws -> Int {
        return try getTeam(id: id).scorePreviousToCurrentPhase
    }
    
    /// Tries to add a team, returns true if team is added, return false if not.
    func addTeam(name:String) throws {
        let count = teams.count
        let inserted:Bool
        if count > 0 {
            inserted = teams.insert(Team.init(name: name, id: count)).inserted
            if (!inserted) {
                throw TeamsError.teamAlreadyInSet(withId: count)
            }
        } else {
            inserted = teams.insert(Team.init(name: name, id: 0)).inserted
            if (!inserted) {
                fatalError("Team cannot be added")
            }
        }
    }
    
    func nextTeamPlaying() {
        if playingTeamId < teams.count - 1 {
            self.playingTeamId = (self.playingTeamId + 1)
        } else {
            self.playingTeamId = 0
        }
    }
    
    func getTeamPlayingName() throws -> String {
            let teamName = try getTeam(id: self.playingTeamId).name
            return teamName
    }
    
    func addTeamScore(id: Int, score: Int) throws {
        var team = try getTeam(id: id)
        team.setScore(team.scorePreviousToCurrentPhase + score)
        let bien = self.teams.update(with: team)
        if bien != nil {
            return
        } else {
            throw TeamsError.updateFailed
        }
    }
    
    func getTeamSortedByScores() throws -> [Team] {
        let teamsSorted = try teams.sorted(by: { (lTeam, rTeam) throws -> Bool in
         lTeam.scorePreviousToCurrentPhase > rTeam.scorePreviousToCurrentPhase
        })
        return teamsSorted
    }
    
    // MARK: - WordSet
    func wordCount() -> Int {
        return wordSet.count()
    }
    
    func setWordSet(wordSet: WordSet) {
        self.wordSet = wordSet
    }
    
    @discardableResult
    func addWordToWordSet(_ word: String) throws -> Word {
        let addedWord = try wordSet.addWord(word)
        return addedWord
    }
    
    func setGuessedWord(_ word: Word, teamId: Int) {
        wordSet.setGuessed(word, teamId: teamId)
    }
}
