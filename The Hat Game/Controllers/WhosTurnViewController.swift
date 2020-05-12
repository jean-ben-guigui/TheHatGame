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
    
    var hatGame:HatGame?
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var whosTurnLabel: UILabel!
    @IBOutlet weak var startGuessingButton: UIButton!
    
    @IBAction func startGuessing(_ sender: UIButton) {
        performSegue(withIdentifier: "startGuessingSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationBarHidden = self.navigationController?.isNavigationBarHidden, !navigationBarHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        if let selfHatGame = hatGame {
            if (segue.identifier == "startGuessingSegue") {
                if let destination = segue.destination as? PlayViewController {
                    destination.hatGame = selfHatGame
                }
            }
        }
    }
    
    func configure() {
        startGuessingButton.layer.cornerRadius = 0.125 * startGuessingButton.bounds.size.width
        startGuessingButton.layer.masksToBounds = true
        startGuessingButton.isEnabled = true
        guard let hatGame = hatGame else {
            fatalError("The hatGame was not injected properly")
        }
        explanationLabel.text = hatGame.phase.explanation
        do {
            let teamPlayingName = try hatGame.getTeamPlayingName()
            whosTurnLabel.text = "Turn to team \(teamPlayingName) to play !"
        } catch {
			let presenter = AlertPresenter(title: Constants.Alert.Title.trouble.rawValue, message: Constants.Alert.Message.nextTeamNotFound, completionAction: nil)
			presenter.present(in: self)
        }
    }
}
