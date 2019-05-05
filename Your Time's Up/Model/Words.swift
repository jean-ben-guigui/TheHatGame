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
            if !addWord(word) {
                print("ERROR - init words - beware there is the same word twice")
            }
        }
    }
    
    func addWord(_ word:String) -> Bool {
        if isWordAlreadyInTheList(word) {
            return false
        } else {
            list.append(Word(word));
            return true
        }
    }
    
    func getNotGuessedWordsDescription() -> [Word] {
        var notGuessedWords:[Word] = []
        for word in list {
            if word.state == wordState.notGuessed {
                notGuessedWords.append(word)
            }
        }
        return notGuessedWords
    }
    
    func isWordAlreadyInTheList(_ wordToCheck:String) -> Bool {
        for word in list {
            if word.description == wordToCheck {
                return true
            }
        }
        return false
    }
    
    func setGuessed(_ guessedWord:Word, teamId:Int) {
        for word in list {
            if guessedWord == word {
                guessedWord.state = wordState.guessed(teamId)
            }
        }
    }
    
    func resetAllWords() {
        for word in list {
            word.state = wordState.notGuessed
        }
    }
}
