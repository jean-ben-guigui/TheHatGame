//
//  WordState.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 20/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

public enum WordState {
    case notGuessed
    case guessed(Int) //teamId
}

public func ==(_ firstWord:WordState, _ secondWord:WordState) -> Bool {
    switch (firstWord, secondWord) {
    case (.notGuessed, .notGuessed):
        return true
    case let (.guessed(a), .guessed(b)):
        return a == b
    default:
        return false
    }
}

public func !=(_ firstWord:WordState, _ secondWord:WordState) -> Bool {
    firstWord == secondWord ? false : true
}
