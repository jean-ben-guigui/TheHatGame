//
//  phaseState.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 28/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

public enum phaseState {
    case none
    case first
    case second
    case third
}

public func ==(_ firstPhase:phaseState, _ secondPhase:phaseState) -> Bool {
    switch(firstPhase, secondPhase) {
    case(.none, .none):
        return true
    case(.first,.first):
        return true
    case(.second,.second):
        return true
    case(.third,.third):
        return true
    default:
        return false
    }
}
