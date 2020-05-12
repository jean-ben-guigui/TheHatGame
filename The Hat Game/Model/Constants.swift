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
    static let minimumNumberOfWordsToPlay = 10
    static let defaultRoundTime = 30
    
    enum phaseExplanation: String {
        case first = "Make your teammates guess the word by saying anything but that word."
        case second = "Make your teammates guess the word by saying only one word."
        case third = "Make your teammates guess the word by miming"
        case none = ""
    }
    
    enum chooseWordSet: String {
        case title = "Do you want to use a set of words that you previously made?"
        case no = "No, create a new set"
        case yes = "Yes"
    }
    
    struct Alert {
        struct Message {
            static let unknow = "An unknown error has happened"
            static let cannotDisplayResults = "The game is over, but the results are unavailable, sorry about that"
            static let tooFewWord = "You have entered less than \(minimumNumberOfWordsToPlay) words, are you sure you want to play with such few words?"
			static let unableToDelete = "There was an error while trying to delete the word set."
            static func wordAlreadyEntered(word: String) -> String {
                   return "The word \(word) has already been entered"
			}
        }
        enum Title: String {
            case trouble = "Oops 😬"
            case unexpectedError = "Error 😵"
        }
    }
    
    static let cancelMessage = "Cancel"
    static let emptyWordSet = "This word set seems to be empty, you should probably delete it."
    static let tieResult = "It's a tie!"
	static let wordSetPrompt = "Click on edit to check the words contained in a word set"
}
