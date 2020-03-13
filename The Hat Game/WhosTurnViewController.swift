//
//  WhosTurnViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 25/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit

class WhosTurnViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    var timesUp:TimesUp?
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var whosTurnLabel: UILabel!
    @IBOutlet weak var startGuessingButton: UIButton!
    
    @IBAction func startGuessing(_ sender: UIButton) {
        performSegue(withIdentifier: "startGuessingSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selfTimesUp = timesUp {
            if (segue.identifier == "startGuessingSegue") {
                if let destination = segue.destination as? PlayViewController {
                    destination.timesUp = selfTimesUp
                }
            }
        }
    }
    
    func configure() {
        startGuessingButton.layer.cornerRadius = 0.125 * startGuessingButton.bounds.size.width
        startGuessingButton.layer.masksToBounds = true
        startGuessingButton.isEnabled = true
        if let nnTimesUp = timesUp {
            explanationLabel.text = nnTimesUp.phase.explanation
            if let teamPlayingName = nnTimesUp.teams.getTeamPlayingName() {
                whosTurnLabel.text = "Turn to team \(teamPlayingName) to play !"
            }
        } else {
            //TODO throw error
            print("ERROR - configure WhosTurnViewController")
        }
    }

}
