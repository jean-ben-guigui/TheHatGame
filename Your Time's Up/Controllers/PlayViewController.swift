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
                if let destination = segue.destination as? PlayViewController {
                    selfTimesUp.teams.nextTeamPlaying()
                    destination.timesUp = selfTimesUp
                }
            } else if (segue.identifier == "presentResultSegue") {
                //TODO final segue
            }
        }
    }
    
    var timesUp:TimesUp?
    var wordToGuess:Word? //points on the current word to guess in timesUp.words.list
    var timer:Timer?
    var timeLeft:Int?

    @IBOutlet weak var theWord: UILabel!
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func successAction(_ sender: UIButton) {
        if var word = wordToGuess {
            if let nnTimesUp = timesUp {
                if let teamId = nnTimesUp.teams.playingTeamId {
                    word.State = wordState.guessed(teamId)
                }
            }
        }
        if timeLeft != 0 {
            randomWord()
        } else {
            performSegue(withIdentifier: "nextTeamSegue", sender: sender)
        }
    }
   
    @IBAction func passAction(_ sender: UIButton) {
        randomWord()
    }
    
    func randomWord() {
        if let nnTimesUp = timesUp {
            let notGuessedWords = nnTimesUp.words.getNotGuessedWordsDescription()
            if notGuessedWords.count == 0 {
                //phase is finished
                if nnTimesUp.nextPhase() {
                    performSegue(withIdentifier: "presentResultSegue", sender: self)
                }
            } else {
                let randomWordIndex = arc4random_uniform(UInt32(notGuessedWords.count - 1))
                wordToGuess = nnTimesUp.words.list[Int(randomWordIndex)]
                theWord.text = wordToGuess?.description
            }
        }
    }
    
    func configure() {
        if let nnTimesUp = timesUp {
            if nnTimesUp.phase.state == phaseState.first {
                passButton.isEnabled = false
            }
        }
        timeLeft = 30
        timer = Timer.init(timeInterval: 1, repeats: true, block: { theTimer in
            self.timeLeft? -= 1
            if let time = self.timeLeft {
                self.timerLabel.text = "\(time) sec"
            }
            if self.timeLeft == 0 {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
        timer?.tolerance = 0.100
    }
}
