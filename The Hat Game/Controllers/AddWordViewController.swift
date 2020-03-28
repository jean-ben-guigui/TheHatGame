//
//  AddWordViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 16/04/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit
import CoreData

class AddWordViewController: UIViewController {
    
    var hatGame:HatGame?
    var wordToValidate:String = ""
    var wordSet:WordSetEntity?
    
    private lazy var wordEntityProvider: WordEntityProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let provider = WordEntityProvider(with: appDelegate.coreDataStack.persistentContainer,
                                   fetchedResultsControllerDelegate: nil)
        return provider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let hatGame = hatGame else {
            fatalError()
        }
        if (segue.identifier == "whosTurnSegue") {
            if let destination = segue.destination as? WhosTurnViewController {
                destination.hatGame = hatGame
            }
        }
    }
    
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
        guard let hatGame = hatGame else {
            fatalError()
        }
        do {
            try hatGame.addWordToWordSet(wordToValidate)
            saveWord(word: wordToValidate)
        } catch {
            let presenter = AlertPresenter(title: Constants.troubleAlertTitle, message: Constants.wordAlreadyEntered(word: wordToValidate), completionAction: nil)
            presenter.present(in: self)
        }
        if hatGame.wordSet.words.count > 23 {
            performSegue(withIdentifier: "whosTurnSegue", sender: self)
        }
        else if let wordNumberString = wordNumberLabel.text {
            if var wordNumberInt = Int(wordNumberString) {
                wordNumberInt += 1
                wordNumberLabel.text = String(wordNumberInt)
                do {
                    let teamPlaying = try hatGame.getTeam(id: wordNumberInt % (hatGame.teams.count))
                    setTeamNameLabel(teamName: teamPlaying.name)
                } catch {
                    print("Silent error: team name not uploaded")
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
        if let nnHatGame = hatGame {
            if nnHatGame.wordCount() < 9 {
                let continueAnywayAction = UIAlertAction(title:"Continue anyway", style: .default, handler: { _ in
                    self.performSegue(withIdentifier: "whosTurnSegue", sender: self)
                    })
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    let presenter = AlertPresenter(
                        title: "Hey there",
                        message: "You have entered less than 10 words, are you sure you want to play with such few words?",
                        completionAction: continueAnywayAction
                    )
                    presenter.present(in: self)
                }
            }
        }
    }
    
    func setTeamNameLabel(teamName:String) {
        teamNameLabel.text = "Team " + teamName + " enters a word"
    }
    
    func saveWord(word: String) {
//        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let wordSet = self.wordSet else {
                return
            }
            let managedContext = wordSet.managedObjectContext!
            
            // 1 Create Word in base
            self.wordEntityProvider.addWordEntity(data: word, context: managedContext, shouldSave: true, completionHandler: { (wordEntity) in
                // 2 Add it to the wordSet
                wordSet.addToWords(wordEntity)
            })
//        }
        
//        wordSet.addToWords()
        
        
      
      /* // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Person",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      person.setValue(name, forKeyPath: "name")
      
      // 4
      do {
        try managedContext.save()
        people.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
 */
    }
    
    func configure(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            guard let hatGame = self.hatGame else {
                return
            }
            self.doneButton.makeMeRound()
            self.doneButton.isEnabled = false
            self.startNowButton.makeMyAnglesRound()
            do {
                let firstTeam = try hatGame.getTeam(id:0)
                self.setTeamNameLabel(teamName: firstTeam.name)
            } catch {
                let presenter = AlertPresenter(
                    title: Constants.unespectedErrorAlertTitle,
                    message: "The team that is supposed to play does not exist, try to close the app and try again.",
                    completionAction: nil
                )
                presenter.present(in: self)
                return
            }
        }
    }
}
