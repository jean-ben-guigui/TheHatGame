//
//  File.swift
//  The Hat Game
//
//  Created by Arthur Duver on 18/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

struct AlertPresenter {
    let title: String
    let message: String
    let completionAction: UIAlertAction?
        
    /// Display a simple alert with the title and message and a cancel button with title "Okay"
    func present(in viewController:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        if let completionAction = completionAction {
            alert.addAction(completionAction)
        }
        viewController.present(alert, animated: false, completion: nil)
    }

}

