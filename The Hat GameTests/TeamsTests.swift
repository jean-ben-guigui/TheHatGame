//
//  TeamsTests.swift
//  The Hat GameTests
//
//  Created by Arthur Duver on 12/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import XCTest
@testable import The_Hat_Game

class TeamsTests: XCTestCase {
    
    var hatGame: HatGame!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.hatGame = HatGame([])
        do {
            try hatGame.addWordToWordSet("johny be good")
            try hatGame.addWordToWordSet("clude")
            try hatGame.addWordToWordSet("humgreufab")
            try hatGame.addWordToWordSet("javac")
            try hatGame.addTeam(name: "commeMaxime")
            try hatGame.addTeam(name: "wingFab")
            try hatGame.addTeam(name: "choupie")
        } catch {
            return
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.hatGame = nil
    }

    func testNextTeamPlaying() {
        XCTAssertEqual(self.hatGame.playingTeamId, 0, "The first team should be playing when we create a brand new hatGame");
        hatGame.nextTeamPlaying()
        XCTAssertEqual(self.hatGame.playingTeamId, 1, "The second team should be playing after calling nextTeamPlaying");
    }
    
    func testGetTeam() {
        XCTAssertEqual(try self.hatGame.getTeam(id: 0).id, 0, "We should get the team with id 0");
    }
    
    func testGetTeamThrow() {
        XCTAssertThrowsError(try self.hatGame.getTeam(id: 12))
    }
    
    func testAddTeam() {
        let count = hatGame.teams.count
        do {
            try hatGame.addTeam(name: "bien")
        } catch {
            XCTFail("Team is supposed to be added")
        }
        XCTAssertEqual(hatGame.teams.count, count + 1, "We should get count + 1")
    }
    
    func testAddTeamScore() {
        do {
            let score = try hatGame.getTeamScorePreviousToCurrentPhase(id: 0)
            try hatGame.addTeamScore(id: 0, score: 12)
            let nextScore = try hatGame.getTeamScorePreviousToCurrentPhase(id: 0)
            XCTAssertEqual(nextScore, score + 12, "Score should have an added value of 12")
        } catch TeamsError.noTeam(withId: 0) {
            XCTFail("Team with id 0 exists")
        } catch TeamsError.updateFailed {
            XCTFail("Team with id 0 exists and should be updatable")
        } catch {
            XCTFail("Unexpected error")
        }
    }
    
    func testWordCount() {
        XCTAssertEqual(hatGame.wordCount(), 4)
    }
    
    func testAddWordToWordSet() {
        let count = hatGame.wordCount()
        do {
            try hatGame.addWordToWordSet("wordNotAlreadyInTheSet")
        } catch {
            XCTFail("The word should be added")
        }
        XCTAssertEqual(hatGame.wordCount(), count + 1, "The count should be + 1")
    }
    
    func testSetGuessedWord() {
        do {
            let word = try hatGame.addWordToWordSet("wordNotAlreadyInTheSet")
            hatGame.setGuessedWord(word, teamId: 0)
        } catch {
            XCTFail("The word should be added")
        }
    }
    
    func testNextPhase() {
        for word in hatGame!.wordSet.words {
            hatGame.setGuessedWord(word, teamId: 0)
        }
        let nextPhase = hatGame.nextPhase()
        XCTAssertTrue(nextPhase)
    }
    
    func testNextPhaseWordsNotGuessed() {
        for word in hatGame!.wordSet.words {
            hatGame.setGuessedWord(word, teamId: 0)
        }
        _ = hatGame.nextPhase()
        var test = true
        for word in hatGame!.wordSet.words {
            if word.state != .notGuessed {
                test = false
            }
        }
        XCTAssertTrue(test)
    }
    
    func testNextPhaseTeamScore() {
        for word in hatGame!.wordSet.words {
            hatGame.setGuessedWord(word, teamId: 0)
        }
        _ = hatGame.nextPhase()
        do {
            let score = try hatGame.getTeamScorePreviousToCurrentPhase(id: 0)
            XCTAssertEqual(score, 4)
        } catch {
            XCTFail()
        }
    }
    
    func testNextPhaseTeamScore2() {
        for (index, word) in hatGame!.wordSet.words.enumerated() {
            if index < 2 {
                hatGame.setGuessedWord(word, teamId: 0)
            } else {
                hatGame.setGuessedWord(word, teamId: 1)
            }
        }
        _ = hatGame.nextPhase()
        do {
            let score = try hatGame.getTeamScorePreviousToCurrentPhase(id: 1)
            XCTAssertEqual(score, 2)
        } catch {
            XCTFail()
        }
    }
}
