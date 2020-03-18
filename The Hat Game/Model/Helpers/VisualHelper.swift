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
    /// Transform a square button into a round one.
    func makeMeRound() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.masksToBounds = true
    }
    
    /// Round the edges of a button
    func makeMyAnglesRound() {
        self.layer.cornerRadius = 0.125 * self.bounds.size.width
        self.layer.masksToBounds = true
    }
}


