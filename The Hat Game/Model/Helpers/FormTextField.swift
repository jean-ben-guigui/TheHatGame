//
//  FormTextField.swift
//  The Hat Game
//
//  Created by Arthur Duver on 09/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
