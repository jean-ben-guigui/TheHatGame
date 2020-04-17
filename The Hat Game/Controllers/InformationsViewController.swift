//
//  InformationsViewController.swift
//  The Hat Game
//
//  Created by Arthur Duver on 16/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import UIKit

class InformationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func dontShowAgain(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "skipHelp")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
