//
//  Constant.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 06/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct Constants {
    static let numberOfPhases = 3
    
    enum phaseExplanation: String {
        case first = "Make your teammates guess the word by saying anything but that word."
        case second = "Make your teammates guess the word by saying only one word."
        case third = "Make your teammates guess the word by miming"
        case none = ""
    }
}
