//
//  ResultTableViewController.swift
//  Your Time's Up
//
//  Created by Arthur Duver on 19/05/2019.
//  Copyright © 2019 Arthur Duver. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    var hatGame:HatGame?
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let nnhatGame = self.hatGame {
            return nnhatGame.teams.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hatGame = hatGame else {
            fatalError()
        }
        // Ask for a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)

        // Configure the cell’s contents with the row and section number.
        // The Basic cell style guarantees a label view is present in textLabel.
        
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
