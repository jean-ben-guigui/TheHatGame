//
//  Words.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 01/05/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation

struct WordSet {
    var words:Set<Word>
    
    init() {
        self.words = Set<Word>()
    }
    
    init(_ words:[String]) {
        self.words = Set<Word>()
        for word in words {
            do {
                try addWord(word)
            }
            catch {
                print("Silent error")
            }
        }
    }
    
    init(wordSetEntity:  WordSetEntity) {
        self.words = Set<Word>()
        guard let words = wordSetEntity.words else {
            return
        }
        for word in words {
            if let word = word as? String {
                do {
                    try addWord(word)
                }
                catch {
                    print("Silent error")
                }
            }
        }
    }
    
    @discardableResult
    mutating func addWord(_ str:String) throws -> Word {
        let word = Word(str)
        let inserted = words.insert(word).inserted
        if inserted == false {
            throw WordSetError.wordAlreadyInSet(word: str)
        }
        return word
    }
    
    func getNotGuessedWords() -> [Word] {
        var notGuessedWords:[Word] = []
        for word in words {
            if word.state == WordState.notGuessed {
                notGuessedWords.append(word)
            }
        }
        return notGuessedWords
    }
    
    func isWordAlreadyInTheList(_ wordToCheck:String) -> Bool {
        words.contains(Word(wordToCheck))
    }
    
    mutating func setGuessed(_ guessedWord: Word, teamId:Int) {
        var word = guessedWord
        word.setState(WordState.guessed(teamId))
        words.update(with: word);
    }
    
    mutating func resetAllWords() {
        for var word in words {
            word.setState(WordState.notGuessed)
            words.update(with: word)
        }
    }
    
    func count() -> Int {
        return words.count
    }
}
