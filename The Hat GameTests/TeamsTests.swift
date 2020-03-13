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
    
    var timesUp: TimesUp!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.timesUp = TimesUp(initWithData: true)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.timesUp = nil
    }

    func testnextTeamPlaying() {
        XCTAssertEqual(self.timesUp.teams.playingTeamId, 0);
        timesUp.teams.nextTeamPlaying()
        XCTAssertEqual(self.timesUp.teams.playingTeamId, 1);
    }
}
