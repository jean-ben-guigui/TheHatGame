//
//  PlayViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 21/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit
import Foundation

class PlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "nextTeamSegue") {
            if let destination = segue.destination as? WhosTurnViewController {
                hatGame.nextTeamPlaying()
                destination.hatGame = hatGame
            }
        } else if (segue.identifier == "presentResultSegue") {
            if let destination = segue.destination as? ResultViewController {
                destination.hatGame = hatGame
                destination.viewModel = Results(hatGame: hatGame)
            }
        } else if (segue.identifier == "nextPhaseSegue") {
            if let destination = segue.destination as? WhosTurnViewController {
                hatGame.nextTeamPlaying()
                destination.hatGame = hatGame
            }
        }
    }
    
    var hatGame:HatGame!
    var wordToGuess:Word? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let word = self?.wordToGuess {
                    self?.theWordLabel.text = word.description
                }
            }
        }
    }
    
    private var timer:Timer?
    private var timeLeft = Constants.defaultRoundTime

    @IBOutlet private weak var theWordLabel: UILabel!
    @IBOutlet private weak var passButton: UIButton!
    @IBOutlet private weak var timerLabel: UILabel!
    
    @IBAction private func successAction(_ sender: UIButton) {
        if let word = wordToGuess {
            hatGame.setGuessedWord(word, teamId: hatGame.playingTeamId)
        }
        randomWord()
    }
   
    @IBAction private func passAction(_ sender: UIButton) {
        randomWord()
    }
    
    ///does some check Up and generate a new word if it is appropriate
    private func randomWord() {
        let notGuessedWords = hatGame.wordSet.getNotGuessedWords()
        if notGuessedWords.count == 0 {
            if hatGame.nextPhase(){
                performSegue(withIdentifier: "nextPhaseSegue", sender: self)
            } else {
                performSegue(withIdentifier: "presentResultSegue", sender: self)
            }
        } else if timeLeft == 0 {
            performSegue(withIdentifier: "nextTeamSegue", sender: self)
        } else if notGuessedWords.count == 1 {
//            passButton.isEnabled = false;
            wordToGuess = notGuessedWords[0]
        }  else {
			let randomWordIndex = Int.random(in: 0..<notGuessedWords.count)
            let newWordToGuess = notGuessedWords[randomWordIndex]
            if let oldWordToGuess = wordToGuess {
                if oldWordToGuess == newWordToGuess {
                    return randomWord()
                }
            }
            wordToGuess = newWordToGuess
        }
    }
    
    ///called by the timer every second
    @objc private func fire(timer: Timer) {
        self.timeLeft -= 1
        self.timerLabel.text = "\(self.timeLeft) sec"
        if self.timeLeft == 0 {
            passButton.isEnabled = true
            timer.invalidate()
//            timesUp()
        }
    }
    
    private func configure() {
        randomWord()
//        if hatGame.phase.state == 1 {
//            passButton.isEnabled = false
//        } else {
        passButton.isEnabled = true
        passButton.setTitle("pass", for:UIControl.State.normal)
//        }
        self.timerLabel.text = "\(self.timeLeft) sec"
        let guessTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        guessTimer.tolerance = 0.100
        RunLoop.current.add(guessTimer, forMode: .common)
    }
}
