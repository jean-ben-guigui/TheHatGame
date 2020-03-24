//
//  Cell.swift
//  The Hat Game
//
//  Created by Arthur Duver on 20/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

class ResultCell: UITableViewCell {
    static let identifier = "ResultCell"
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var score: UILabel!
    
    // MARK: - Table View Cell
    override func prepareForReuse() {
      super.prepareForReuse()
      
      teamName.text = nil
      rank.text = nil
      score.text = nil
    }
}
