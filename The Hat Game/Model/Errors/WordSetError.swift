//
//  WordSetError.swift
//  The Hat Game
//
//  Created by Arthur Duver on 16/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

enum WordSetError: Error {
    case wordAlreadyInSet(word: String)
}
