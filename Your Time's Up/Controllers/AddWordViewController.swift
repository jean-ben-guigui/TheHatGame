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
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func validateWord(_ sender: UIButton) {
        print("Time's up : \(String(describing:timesUp.teams.count))")
    }
    var timesUp:TimesUp = TimesUp.init([])
    
    

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
        doneButton.isEnabled = true
    }

}
