//
//  AddWordViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 16/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit

class AddWordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selfTimesUp = timesUp {
            if (segue.identifier == "whosTurnSegue") {
                if let destination = segue.destination as? WhosTurnViewController {
                    selfTimesUp.phase.state = 1
                    destination.timesUp = selfTimesUp
                }
            }
        }
    }
    
    var timesUp:TimesUp?
    var wordToValidate:String =  ""
    
    @IBOutlet var addWordView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var startNowButton: UIButton!
    @IBOutlet weak var wordNumberLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var wordInput: UITextField!
    
    /// Handles the validation of a word entered by the user:
    /// - display an alert if the word already exists
    /// - adjust the number /24 and the name of the team that should be entering the next word
    @IBAction func validateWord(_ sender: UIButton) {
        if let nnTimesUp = timesUp {
            if !nnTimesUp.words.addWord(wordToValidate) {
                displayAlert(viewControllerPresenting:self, title: "Oops 😬", message: "Someone already entered that word, please choose something different")
            }
            if(timesUp!.words.list.count > 23) {
                performSegue(withIdentifier: "whosTurnSegue", sender: self)
            }
            else if let wordNumberString = wordNumberLabel.text {
                if var wordNumberInt = Int(wordNumberString) {
                    wordNumberInt += 1
                    wordNumberLabel.text = String(wordNumberInt)
                    if let teamPlaying = nnTimesUp.teams.getTeam(id: wordNumberInt % (nnTimesUp.teams.list.count)) {
                        setTeamNameLabel(teamName: teamPlaying.name)
                    }
                }
            }
        }
        wordInput.text = ""
    }
    
    @IBAction func wordEdited(_ sender: UITextField) {
        if let word = sender.text  {
            wordToValidate = word
            if word != "" {
                doneButton.isEnabled = true
            } else {
                 doneButton.isEnabled = false
            }
        }
    }
    
    @IBAction func startNow(_ sender: Any) {
        if let nnTimesUp = timesUp {
            if nnTimesUp.words.list.count < 9 {
                let continueAnywayAction = UIAlertAction(title:"Continue anyway", style: .default, handler: { _ in
                    self.performSegue(withIdentifier: "whosTurnSegue", sender: self)
                    })
                displayAlert(viewControllerPresenting: self, title: "Hey there", message: "You have entered less than 10 words, are you sure you want to play with such few words?", completion: continueAnywayAction)
            }
        }
    }
    
    
    
    func setTeamNameLabel(teamName:String) {
        teamNameLabel.text = "Team " + teamName + " enters a word"
    }
    
    func configure(){
        doneButton.makeMeRound()
        doneButton.isEnabled = false
        startNowButton.makeMyAnglesRound()
        if let nnTimesUp = timesUp {
            if let firstTeam = nnTimesUp.teams.getTeam(id:0) {
                setTeamNameLabel(teamName: firstTeam.name)
            }
        } else {
            print("ERROR : no first team injected")
        }
    }
}
