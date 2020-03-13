//
//  wordState.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 20/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

public enum wordState {
    case notGuessed
    case guessed(Int) //teamId
}

public func ==(_ firstWord:wordState, _ secondWord:wordState) -> Bool {
    switch (firstWord, secondWord) {
    case (.notGuessed, .notGuessed):
        return true
    case let (.guessed(a), .guessed(b)):
        return a == b
    default:
        return false
    }
}
