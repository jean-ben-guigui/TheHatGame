//
//  Phase.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 28/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

struct Phase {
    var state:Int {
        didSet {
            ///Verifies that the state is okay
            if state < 0 {
                state = 0
            } else if state > Constants.numberOfPhases {
                state = 3
            }
            
            ///Sets the explanations
            switch state {
            case 0:
                self.explanation = Constants.phaseExplanation.none.rawValue
            case 1:
                self.explanation = Constants.phaseExplanation.first.rawValue
            case 2:
                self.explanation = Constants.phaseExplanation.second.rawValue
            case 3:
                self.explanation = Constants.phaseExplanation.third.rawValue
            default:
                self.explanation = Constants.phaseExplanation.none.rawValue
            }
        }
    }
    var explanation:String
    
    init() {
        self.explanation = "" //necessary for compilation
        self.state = 0
    }
}
