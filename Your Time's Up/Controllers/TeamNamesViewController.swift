//
//  ViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 10/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit

class TeamNamesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configure();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let timesUp = TimesUp([])
        addTeam(timesUp: timesUp, button: firstTeamName)
        addTeam(timesUp: timesUp, button: secondTeamName)
        addTeam(timesUp: timesUp, button: thirdTeamName)
        addTeam(timesUp: timesUp, button: fourthTeamName)
        //TODO check that there is not 2 teams sharing a same name (nouvelle méthode pour Teams)
        if (segue.identifier == "addWordsSegue") {
            if let addWordController = segue.destination as? AddWordViewController {
                addWordController.timesUp = timesUp
            }
        }
    }
    @IBOutlet weak var firstTeamName: UITextField!
    @IBOutlet weak var secondTeamName: UITextField!
    @IBOutlet weak var thirdTeamName: UITextField!
    @IBOutlet weak var fourthTeamName: UITextField!
    
    @IBOutlet weak var startTheGameButton: UIButton!
    @IBAction func firstTeamNameEdited(_ sender: UITextField) {
        setGameButtonState()
    }
    @IBAction func secondTeamNameEdited(_ sender: UITextField) {
        setGameButtonState()
    }
    @IBAction func thirdTeamNameEdited(_ sender: UITextField) {
         setGameButtonState()
    }
    @IBAction func fourthTeamNameEdited(_ sender: UITextField) {
         setGameButtonState()
    }
    
    @IBAction func StartTheGame(_ sender: UIButton) {
        performSegue(withIdentifier: "addWordsSegue", sender: sender)
    }
    
//    func addTeam(sender:UITextField) {
//        if let teamName = sender.text {
//            if teamName == ""{
//                //Si le nom d'équipe a été éffacé, on le supprime dans le dictionnary teams.
//                teams.removeValue(forKey: 0)
//            } else {
//                //Si le nom d'équipe est rentré, on le met à jour
//                teams[0] = teamName
//            }
//        }
//        startTheGameButton.isEnabled = !teams.isEmpty
//    }
    
    func areTeamNamesEmpty() -> Bool {
        if firstTeamName.text != "" || secondTeamName.text != "" || thirdTeamName.text != "" || fourthTeamName.text != "" {
            return false
        }
        return true
    }
    
    func addTeam(timesUp:TimesUp, button:UITextField) {
        if let teamName = button.text {
            if teamName != "" {
                timesUp.teams.addTeam(name: teamName)
            }
        }
    }
    
    func setGameButtonState() {
        startTheGameButton.isEnabled = !areTeamNamesEmpty()
    }
    
    func configure() {
        startTheGameButton.layer.cornerRadius = 0.125 * startTheGameButton.bounds.size.width
        startTheGameButton.layer.masksToBounds = true
        startTheGameButton.isEnabled = false
        //TODO bind isEnabled to teamNames being all = ""
        startTheGameButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
    }
}

