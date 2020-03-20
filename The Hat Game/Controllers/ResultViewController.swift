//
//  ResultViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 19/05/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBOutlet weak var resultTableView: UITableView!
    var hatGame:HatGame?
}

// MARK: - Table View Data Source

extension ResultViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let nnhatGame = self.hatGame {
            return nnhatGame.teams.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hatGame = hatGame else {
            fatalError()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        
        do {
            let teamToDisplay = try hatGame.getTeam(id: indexPath.row)
            if let cellDetailTextLabel = cell.detailTextLabel {
                cellDetailTextLabel.text = "\(teamToDisplay.scorePreviousToCurrentPhase)"
            }
            if let cellTextLabel = cell.textLabel {
                cellTextLabel.text = "\(teamToDisplay.name)"
            }
        } catch {
            let presenter = AlertPresenter(title: Constants.unespectedErrorAlertTitle, message: "The game is over, but the results are unavailable, sorry about that", completionAction: nil)
            presenter.present(in: self)
        }
        
        return cell
    }
}

// MARK: - Table View Delegate

extension ResultViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
