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

        // Do any additional setup after loading the view.
        
        configure()
    }
    
    var timesUp:TimesUp?
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var whosTurnLabel: UILabel!
    @IBOutlet weak var startGuessingButton: UIButton!
    
    @IBAction func startGuessing(_ sender: UIButton) {
        performSegue(withIdentifier: "startGuessingSegue", sender: sender)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configure() {
        startGuessingButton.layer.cornerRadius = 0.125 * startGuessingButton.bounds.size.width
        startGuessingButton.layer.masksToBounds = true
        startGuessingButton.isEnabled = true
        if let nnTimesUp = timesUp {
            explanationLabel.text = nnTimesUp.phase.explanation
        } else {
            //TODO throw error
        }
    }

}
