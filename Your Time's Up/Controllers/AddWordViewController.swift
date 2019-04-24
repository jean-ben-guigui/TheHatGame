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
        print("AddWordView did load")
        // Do any additional setup after loading the view.
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selfTimesUp = timesUp {
            if (segue.identifier == "playSegue") {
                if let destination = segue.destination as? PlayViewController {
                    destination.timesUp = selfTimesUp
                }
            }
        }
        
    }
    
    
    var timesUp:TimesUp?
    var wordToValidate:String =  ""
    
    @IBOutlet var addWordView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var wordNumberLabel: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var wordInput: UITextField!
    
    /// Handles the validation of a word entered by the user:
    /// - display an alert if the word already exists
    /// - adjust the number /24 and the name of the team that should be entering the next word
    @IBAction func validateWord(_ sender: UIButton) {
        if let nnTimesUp = timesUp {
            if nnTimesUp.words.index(forKey: wordToValidate) != nil {
                displayAlert(title: "Oops 😬", message: "Someone already entered that word, please choose something different")
            } else {
                nnTimesUp.words[wordToValidate] = wordState.notGuessed
                if(timesUp!.words.count > 23) {
                    print(String(describing: timesUp!.words))
                    //TODO go to next screen
                    
                }
                else if let wordNumberString = wordNumberLabel.text {
                    if var wordNumberInt = Int(wordNumberString) {
                        wordNumberInt += 1
                        wordNumberLabel.text = String(wordNumberInt)
                        if let nnTimesUp = timesUp {
                            if let teamPlaying = nnTimesUp.getTeam(id: wordNumberInt % (nnTimesUp.teams.count)) {
                                teamName.text = teamPlaying.name
                            }
                        }
                    }
                }
            }
            wordInput.text = ""
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// display a simple alert with the title and message and a cancel button with title "Okay"
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        print((String(describing: self)))
        self.present(alert, animated: false, completion: nil)
    }
    
    func configure(){
        doneButton.layer.cornerRadius = 0.5 * doneButton.bounds.size.width
        doneButton.layer.masksToBounds = true
        doneButton.isEnabled = false
        if let nnTimesUp = timesUp {
            if let firstTeam = nnTimesUp.getTeam(id:1) {
                teamName.text = firstTeam.name
            }
        } else {
            print("ERROR : no first team injected")
        }
    }
}
