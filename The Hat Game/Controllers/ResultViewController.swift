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

        setWinnerLabelsVisibility(alpha: 0.0)
        
        setupTableView()
    }
    
    @IBOutlet weak var emojisLabel: UILabel!
    @IBOutlet weak var winnerIsLabel: UILabel!
    @IBOutlet weak var winnerTeamName: UILabel!
    @IBOutlet weak var resultTableView: UITableView!
    
    
    @IBAction func playAgain(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    var hatGame: HatGame!
    var viewModel: Results!
    var scores = [TeamRank]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                if self.isViewLoaded {
                    self.resultTableView.reloadData()
                }
            }
        }
    }
    
    func setWinnerLabelsVisibility(alpha: Double, animationTime: Double = 0, tie: Bool = false) {
        UIView.animate(withDuration: animationTime, delay: 0, options: .curveEaseIn,  animations: {
            self.winnerTeamName.alpha = CGFloat(alpha)
            self.emojisLabel.alpha = CGFloat(alpha)
            if !tie {
                self.winnerIsLabel.alpha = CGFloat(alpha)
            } else {
                self.emojisLabel.text = "😮😮😮"
            }
        })
    }
    
    private func setupTableView() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            do {
                self.scores = try self.viewModel.getTeamRanks()
                let bestScore = self.scores[0]
                let tie = self.scores[1].team.scorePreviousToCurrentPhase == self.scores[0].team.scorePreviousToCurrentPhase
                DispatchQueue.main.async {
                    self.winnerTeamName.text = tie ? Constants.tieResult : bestScore.team.name
                    self.setWinnerLabelsVisibility(alpha: 1.0, animationTime: 2, tie: tie)
                }
            } catch {
               let presenter = AlertPresenter(
                title: Constants.Alert.Title.unexpectedError.rawValue,
                message: Constants.Alert.Message.cannotDisplayResults,
                completionAction: nil)
               presenter.present(in: self)
            }
        }
    }
}

// MARK: - Table View Data Source

extension ResultViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        let teamToDisplay = scores[indexPath.row]
        cell.score?.text = "\(teamToDisplay.team.scorePreviousToCurrentPhase) pts"
        cell.teamName?.text = "\(teamToDisplay.team.name)"
        cell.rank?.text = teamToDisplay.rank
        
        return cell
    }
}

// MARK: - Table View Delegate

extension ResultViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
