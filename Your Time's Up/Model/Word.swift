//
//  Word.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 12/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

class Word {
    var description:String
    var state:wordState
    
    init(_ description:String) {
        self.description = description
        self.state = wordState.notGuessed
    }
    
    static func ==(_ word1:Word, _ word2:Word) -> Bool {
        if word1.description == word2.description {
            return true
        }
        return false
    }
    
    func setState(_ newState:wordState) {
        state = newState
    }
}
