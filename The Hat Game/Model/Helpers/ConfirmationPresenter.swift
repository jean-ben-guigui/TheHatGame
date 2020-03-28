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
    let title: String?
    let message: String
    let completionActions: [UIAlertAction]
    
    init(title: String?, message: String, completionAction: UIAlertAction?) {
        self.title = title
        self.message = message
        self.completionActions = completionAction != nil ? [completionAction!] : []
    }
    
    init(title: String?, message: String, completionActions: [UIAlertAction]) {
        self.title = title
        self.message = message
        self.completionActions = completionActions
    }
        
    /// Display a simple alert with the title and message and a cancel button with title "Okay"
    func present(in viewController:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if completionActions.count < 2 {
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        }
        for completionAction in completionActions {
            alert.addAction(completionAction)
        }
        
        viewController.present(alert, animated: false, completion: nil)
    }

}

