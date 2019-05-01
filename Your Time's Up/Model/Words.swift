//
//  Words.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 01/05/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

class Words {
    var list:[Word]
    
    init() {
        self.list = []
    }
    
    init(_ words:[String]) {
        self.list = []
        for word in words {
            addWord(word)
        }
    }
    
    func addWord(_ word:String) {
        list.append(Word(word));
    }
    
    func getNotGuessedWordsDescription() -> [Word] {
        var notGuessedWords:[Word] = []
        for word in list {
            if word.State == wordState.notGuessed {
                notGuessedWords.append(word)
            }
        }
        return notGuessedWords
    }
    
    func isWordIsAlreadyInTheList(_ wordToCheck:String) -> Bool {
        for word in list {
            if word.description == wordToCheck {
                return true
            }
        }
        return false
    }
}
