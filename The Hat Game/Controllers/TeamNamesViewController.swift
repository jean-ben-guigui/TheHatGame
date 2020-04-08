//
//  ViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 10/03/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit
import CoreData

class TeamNamesViewController: UIViewController {
    
    private lazy var wordSetEntityProvider: WordSetEntityProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let provider = WordSetEntityProvider(with: appDelegate.coreDataStack.persistentContainer,
                                   fetchedResultsControllerDelegate: nil)
        return provider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let hatGame = HatGame([])
        addTeam(hatGame: hatGame, button: firstTeamName)
        addTeam(hatGame: hatGame, button: secondTeamName)
        addTeam(hatGame: hatGame, button: thirdTeamName)
        addTeam(hatGame: hatGame, button: fourthTeamName)
        // TODO maybe check that there is not 2 teams sharing a same name (nouvelle méthode pour Teams). Since we check it when the startTheGameButton is pressed, no real needs to do so though.
        if (segue.identifier == "addWordsSegue") {
            if let addWordController = segue.destination as? AddWordViewController {
                addWordController.hatGame = hatGame
                wordSetEntityProvider.addWordSet(in: wordSetEntityProvider.persistentContainer.viewContext, completionHandler: { (wordSetEntity) in
                    addWordController.wordSet = wordSetEntity
                })
            }
        }
        if (segue.identifier == "chooseWordSetSegue") {
            // TODO add wordSetsToPass to the destination controller
        }
    }
    @IBOutlet private weak var firstTeamName: UITextField!
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
        // fetches the WordSet objects from the database.
        if wordSetEntityProvider.areWordSetsNil() {
            self.performSegue(withIdentifier: "addWordsSegue", sender: sender)
        } else {
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { [unowned self] (alertAction)  in
                self.performSegue(withIdentifier: "chooseWordSetSegue", sender: sender)
            })
            let createNewSetAction = UIAlertAction(title: "No, create a new set", style: .cancel, handler: { [unowned self] (alertAction) in
                self.performSegue(withIdentifier: "addWordsSegue", sender: sender)
            })
            let chooseWordSetPresenter = AlertPresenter(title: nil, message: "Do you want to use a set of words that you previously made?", completionActions: [yesAction, createNewSetAction])
            chooseWordSetPresenter.present(in: self)
        }
    }
    
    func areTeamNamesEmpty() -> Bool {
        if firstTeamName.text != "" ||
            secondTeamName.text != "" ||
            thirdTeamName.text != "" ||
            fourthTeamName.text != "" {
            return false
        }
        return true
    }
    
    func areThereTwoTeamsName() -> Bool {
        let teamNames = [firstTeamName.text, secondTeamName.text, thirdTeamName.text, fourthTeamName.text]
        var teamCount = 0
        for teamName in teamNames {
            if teamName != "" {
                teamCount += 1
                if teamCount > 1 {
                    return true
                }
            }
        }
        return false
    }
    
    func addTeam(hatGame:HatGame, button:UITextField) {
        if let teamName = button.text {
            if teamName != "" {
                do {
                    try hatGame.addTeam(name: teamName)
                } catch WordSetError.wordAlreadyInSet(let word) {
                    let presenter = AlertPresenter(
                        title: Constants.Alert.Title.trouble.rawValue,
                        message: Constants.Alert.Message.wordAlreadyEntered(word: word),
                        completionAction: nil
                    )
                    presenter.present(in: self)
                } catch {
                    let presenter = AlertPresenter(
                        title: Constants.Alert.Title.trouble.rawValue,
                        message: Constants.Alert.Message.unknow,
                        completionAction: nil
                    )
                    presenter.present(in: self)
                }
            }
        }
    }
    
    func setGameButtonState() {
        startTheGameButton.isEnabled = areThereTwoTeamsName()
    }
    
    func configure() {
        startTheGameButton.makeMyAnglesRound()
        startTheGameButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        setGameButtonState()
    }
}
