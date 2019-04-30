//
//  Phase.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 28/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

struct Phase {
    var state:phaseState {
        didSet {
            switch state {
            case phaseState.first:
                self.explanation = phaseExplanation.first.rawValue
            case phaseState.second:
                self.explanation = phaseExplanation.second.rawValue
            case phaseState.third:
                self.explanation = phaseExplanation.third.rawValue
            default:
                self.explanation = phaseExplanation.none.rawValue
            }
        }
    }
    var explanation:String
    
    init() {
        self.explanation = "" //necessary for compilation
        self.state = phaseState.none
    }
}
