//
//  WordSetTests.swift
//  The Hat GameTests
//
//  Created by Arthur Duver on 11/05/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import XCTest
@testable import The_Hat_Game

class WordSetTests: XCTestCase {
//	var hatGame: HatGame!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		
		
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetNotGuessedTwoWords() throws {
		executionTimeAllowance = 5
		let wordSet = WordSet(["test1", "test2"])
		let words = wordSet.getNotGuessedWords()
		XCTAssertEqual(words.count, 2)
    }
	
	func NotTerribletestTwoWordsAndPass() throws {
		let hatGame = HatGame(data: false, result: false)
		do {
			try hatGame.addWordToWordSet("humgreufab")
			try hatGame.addWordToWordSet("javac")
			try hatGame.addTeam(name: "commeMaxime")
			try hatGame.addTeam(name: "wingFab")
		} catch {
			fatalError("WordSetTests: unable to add team and words to hatGame")
		}
		let vc = (UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "playViewControllerID") as! PlayViewController)
//			UIApplication.shared.keyWindow?.rootViewController = vc
		vc.hatGame = hatGame
//		vc.
//			XCTAssertEqual( vc., "View Controller created from: storyboard")
	}
	
//	PlayViewController()

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
