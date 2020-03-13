//
//  Words.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 01/05/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

struct Words {
    var list:Set<Word>
    
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
    
    mutating func addWord(_ word:String) -> Bool {
        return list.insert(Word(word)).inserted
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
        list.contains(Word(wordToCheck))
    }
    
    mutating func setGuessed(_ guessedWord: Word, teamId:Int) {
//        for (word, index) in list. {
//            if guessedWord == word {
//                listword.state = wordState.guessed(teamId)
//                break;
//            }
//        }
        var word = guessedWord
        word.setState(wordState.guessed(teamId))
        list.update(with: word);
    }
    
    mutating func resetAllWords() {
        for var word in list {
            word.setState(wordState.notGuessed)
            list.update(with: word)
        }
    }
}
