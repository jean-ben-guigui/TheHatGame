//
//  visualHelper.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 05/05/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    ///transform a square button into a round one.
    func makeMeRound() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.masksToBounds = true
    }
    
    ///round the edges of button
    func makeMyAnglesRound() {
        self.layer.cornerRadius = 0.125 * self.bounds.size.width
        self.layer.masksToBounds = true
    }
}

/// display a simple alert with the title and message and a cancel button with title "Okay"
func displayAlert(viewControllerPresenting:UIViewController, title:String, message:String, completion:UIAlertAction? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
    if let completionAction = completion {
        alert.addAction(completionAction)
    }
    viewControllerPresenting.present(alert, animated: false, completion: nil)
}


