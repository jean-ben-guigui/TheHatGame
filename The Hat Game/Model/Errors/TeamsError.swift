//
//  File.swift
//  The Hat Game
//
//  Created by Arthur Duver on 13/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

enum TeamsError : Error {
    case notEnoughTeams
    case noTeam(withId: Int)
    case updateFailed
    case teamAlreadyInSet(withId: Int)
}
