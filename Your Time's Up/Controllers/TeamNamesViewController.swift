//
//  ViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 10/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit

class TeamNamesViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue")
        if (segue.identifier == "playSegue") {
            print("prepareForSegue playsegue")
            let addWordController = segue.destination as! AddWordViewController
            addWordController.timesUp = timesUp
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configure();
    }

    var teams:[Int:String] = [:];
    var timesUp:TimesUp = TimesUp.init([])
    
    @IBOutlet weak var startTheGameButton: UIButton!
    
    @IBAction func firstName(_ sender: UITextField) {
        if let teamName = sender.text {
            if teamName == ""{
                //Si le nom d'équipe a été éffacé, on le supprime dans le dictionnary teams.
                teams.removeValue(forKey: 1)
            } else {
                //Si le nom d'équipe est rentré, on le met à jour
                teams[1] = teamName
            }
        }
        startTheGameButton.isEnabled = !teams.isEmpty
    }
    
    @IBAction func secondName(_ sender: UITextField) {
        if let teamName = sender.text {
            if teamName == ""{
                //Si le nom d'équipe a été éffacé, on le supprime dans le dictionnary teams.
                teams.removeValue(forKey: 2)
            } else {
                //Si le nom d'équipe est rentré, on le met à jour
                teams[2] = teamName
            }
        }
        startTheGameButton.isEnabled = !teams.isEmpty
    }
    @IBAction func thirdName(_ sender: UITextField) {
        if let teamName = sender.text {
            if teamName == ""{
                //Si le nom d'équipe a été éffacé, on le supprime dans le dictionnary teams.
                teams.removeValue(forKey: 3)
            } else {
                //Si le nom d'équipe est rentré, on le met à jour
                teams[3] = teamName
            }
        }
        startTheGameButton.isEnabled = !teams.isEmpty
    }
   
    @IBAction func forthName(_ sender: UITextField) {
        if let teamName = sender.text {
            if teamName == ""{
                //Si le nom d'équipe a été éffacé, on le supprime dans le dictionnary teams.
                teams.removeValue(forKey: 4)
            } else {
                //Si le nom d'équipe est rentré, on le met à jour
                teams[4] = teamName
            }
        }
        startTheGameButton.isEnabled = !teams.isEmpty
    }
    
    @IBAction func StartTheGame(_ sender: UIButton) {
        print("Le jeux commence, les équipes sont les suivantes : \(String(describing:teams))")
        var teamsAboutToPlay:[Team] = []
        for team in teams {
            teamsAboutToPlay.append(Team.init(name: team.value))
        }
        //TODO verifie that there is not 2 teams sharing a same name
        timesUp = TimesUp.init(teamsAboutToPlay)
        performSegue(withIdentifier: "playSegue", sender: sender)
    }
    
   
    
    func configure() {
        startTheGameButton.layer.cornerRadius = 0.125 * startTheGameButton.bounds.size.width
        startTheGameButton.layer.masksToBounds = true
        startTheGameButton.isEnabled = false
        startTheGameButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
    }
}

