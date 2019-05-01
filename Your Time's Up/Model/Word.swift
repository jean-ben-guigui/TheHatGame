//
//  Word.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 12/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

struct Word {
    var description:String
    var State:wordState
    
    init(_ description:String) {
        self.description = description
        self.State = wordState.notGuessed
    }
}
