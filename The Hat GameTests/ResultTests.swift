//
//  ResultTests.swift
//  The Hat GameTests
//
//  Created by Arthur Duver on 20/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import XCTest
@testable import The_Hat_Game

class ResultTests: XCTestCase {
    
    var hatGame: HatGame!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.hatGame = HatGame(data: true, result: true)
    }

    func testExample() throws {
        let resultViewModel = Results(hatGame: hatGame)
        do {
//            let teams = try hatGame.getTeamSortedByScores()
            let ranks = try resultViewModel.getTeamRanks()
			XCTAssertEqual(ranks[1].rank, "1st", "When there is a tie, the ranks should reflect it")
        } catch {
            XCTFail("Unexpected error")
        }
        
    }
}
