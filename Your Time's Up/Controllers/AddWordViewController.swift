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
    
    
    var timesUp:TimesUp = TimesUp.init([])
    var wordToValidate:String = ""
    var teamIndex:Int = 0
    
    @IBOutlet var addWordView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var wordNumberLabel: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var wordInput: UITextField!
    
    
    @IBAction func validateWord(_ sender: UIButton) {
        if timesUp.words.index(forKey: wordToValidate) != nil {
            let alert = UIAlertController(title: "Oops 😬", message: "Someone already entered that word, please choose something different", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            print((String(describing: self)))
            self.present(alert, animated: false, completion: nil)
        } else {
            timesUp.words[wordToValidate] = wordState.notGuessed
            if(timesUp.words.count > 23) {
                print(String(describing: timesUp.words))
                //TODO go to next screen
                
            }
            else if let wordNumberString = wordNumberLabel.text {
                if var wordNumberInt = Int(wordNumberString) {
                    wordNumberInt += 1
                    wordNumberLabel.text = String(wordNumberInt)
                    if timesUp.teams.count <= teamIndex + 1 {
                        teamIndex = 0
                    } else {
                        teamIndex += 1
                    }
                    teamName.text = timesUp.teams[teamIndex].name
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configure(){
        doneButton.layer.cornerRadius = 0.5 * doneButton.bounds.size.width
        doneButton.layer.masksToBounds = true
        doneButton.isEnabled = false
        teamName.text = timesUp.teams[0].name
    }

}
