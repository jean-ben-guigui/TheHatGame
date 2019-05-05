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
        if let selfTimesUp = timesUp {
            if (segue.identifier == "nextTeamSegue") {
                if let destination = segue.destination as? WhosTurnViewController {
                    selfTimesUp.teams.nextTeamPlaying()
                    destination.timesUp = selfTimesUp
                }
            } else if (segue.identifier == "presentResultSegue") {
//                if let destination = segue.destination as? WhosTurnViewController {
//                    destination.timesUp = selfTimesUp
//                }
            } else if (segue.identifier == "nextPhaseSegue") {
                if let destination = segue.destination as? WhosTurnViewController {
                    destination.timesUp = selfTimesUp
                }
            }
        }
    }
    
    var timesUp:TimesUp?
    var wordToGuess:Word? {
        didSet {
            if let word = wordToGuess {
                theWordLabel.text = word.description
            }
        }
    }
    
    var timer:Timer?
    var timeLeft:Int?

    @IBOutlet weak var theWordLabel: UILabel!
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func successAction(_ sender: UIButton) {
        if let nnTimesUp = timesUp {
            if let word = wordToGuess {
                if let teamId = nnTimesUp.teams.playingTeamId {
                    nnTimesUp.words.setGuessed(word, teamId: teamId)
                }
            }
        }
        randomWord()
    }
   
    @IBAction func passAction(_ sender: UIButton) {
        randomWord()
    }
    
    ///does some check Up and generate a new word if it is appropriate
    func randomWord() {
        if let nnTimesUp = timesUp {
            let notGuessedWords = nnTimesUp.words.getNotGuessedWordsDescription()
            if notGuessedWords.count == 0 {
                if nnTimesUp.nextPhase(){
                    performSegue(withIdentifier: "nextPhaseSegue", sender: self)
                } else {
                    performSegue(withIdentifier: "presentResultSegue", sender: self)
                }
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
    }
    
    ///called by the timer every second
    @objc func fire() {
        self.timeLeft? -= 1
        if let time = self.timeLeft {
            self.timerLabel.text = "\(time) sec"
        }
        if self.timeLeft == 0 {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func configure() {
        randomWord()
        if let nnTimesUp = timesUp {
            if nnTimesUp.phase.state == phaseState.first {
                passButton.isEnabled = false
            } else {
                passButton.isEnabled = true
                passButton.setTitle("pass", for:UIControl.State.normal)
            }
        }
        timeLeft = 30
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        timer?.tolerance = 0.100
    }
}
