//
//  File.swift
//  The Hat Game
//
//  Created by Arthur Duver on 18/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

protocol AlertPresentable where Self: UIViewController {
    /// Display a simple alert with the title and message and a cancel button with title "Okay"
    func displayAlert(viewControllerPresenting:UIViewController, title:String, message:String, completion:UIAlertAction?)
}

extension AlertPresentable {
    func displayAlert(title:String, message:String, completion:UIAlertAction? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        if let completionAction = completion {
            alert.addAction(completionAction)
        }
        self.present(alert, animated: false, completion: nil)
    }
}
