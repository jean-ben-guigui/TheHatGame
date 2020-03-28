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
        guard let hatGame = hatGame else {
            fatalError()
        }
        if (segue.identifier == "nextTeamSegue") {
            if let destination = segue.destination as? WhosTurnViewController {
                hatGame.nextTeamPlaying()
                destination.hatGame = hatGame
            }
        } else if (segue.identifier == "presentResultSegue") {
            if let destination = segue.destination as? ResultViewController {
                destination.hatGame = hatGame
            }
        } else if (segue.identifier == "nextPhaseSegue") {
            if let destination = segue.destination as? WhosTurnViewController {
                hatGame.nextTeamPlaying()
                destination.hatGame = hatGame
            }
        }
    }
    
    var hatGame:HatGame?
    var wordToGuess:Word? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let word = self?.wordToGuess {
                    self?.theWordLabel.text = word.description
                }
            }
        }
    }
    
    var timer:Timer?
    var timeLeft = Constants.defaultRoundTime

    @IBOutlet weak var theWordLabel: UILabel!
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func successAction(_ sender: UIButton) {
        guard let hatGame = self.hatGame else {
            fatalError()
        }
        if let word = wordToGuess {
            hatGame.setGuessedWord(word, teamId: hatGame.playingTeamId)
        }
        randomWord()
    }
   
    @IBAction func passAction(_ sender: UIButton) {
        randomWord()
    }
    
    ///does some check Up and generate a new word if it is appropriate
    func randomWord() {
        guard let hatGame = self.hatGame else {
            fatalError()
        }
        let notGuessedWords = hatGame.wordSet.getNotGuessedWords()
        if notGuessedWords.count == 0 {
            if hatGame.nextPhase(){
                performSegue(withIdentifier: "nextPhaseSegue", sender: self)
            } else {
                performSegue(withIdentifier: "presentResultSegue", sender: self)
            }
        } else if notGuessedWords.count == 1 {
            passButton.isEnabled = false;
            wordToGuess = notGuessedWords[0]
        } else if timeLeft == 0 {
            performSegue(withIdentifier: "nextTeamSegue", sender: self)
        } else {
            let randomWordIndex = Int(arc4random_uniform(UInt32(notGuessedWords.count - 1)))
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
    @objc func fire(timer: Timer) {
        self.timeLeft -= 1
        self.timerLabel.text = "\(self.timeLeft) sec"
        if self.timeLeft == 0 {
            timer.invalidate()
            timesUp()
        }
    }
    
    func configure() {
        randomWord()
        if let nnHatGame = hatGame {
            if nnHatGame.phase.state == 1 {
                passButton.isEnabled = false
            } else {
                passButton.isEnabled = true
                passButton.setTitle("pass", for:UIControl.State.normal)
            }
        }
        self.timerLabel.text = "\(self.timeLeft) sec"
        let guessTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        guessTimer.tolerance = 0.100
        RunLoop.current.add(guessTimer, forMode: .common)
    }
    
    func timesUp() {
        
    }
}
