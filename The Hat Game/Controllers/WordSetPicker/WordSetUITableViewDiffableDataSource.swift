//
//  WordSetUITableViewDiffableDataSource.swift
//  The Hat Game
//
//  Created by Arthur Duver on 08/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WordSetUITableViewDiffableDataSource: UITableViewDiffableDataSource<WordSetTableViewSection, WordSetEntity> {
	
    var wordSetEntityProvider: WordSetEntityProvider?
    var fetchedResultsController: NSFetchedResultsController<WordSetEntity>?
	var viewController: UIViewController
	
	init(tableView: UITableView, viewController: UIViewController, cellProvider: @escaping CellProvider) {
		self.viewController = viewController
		super.init(tableView: tableView, cellProvider: cellProvider)
	}
    
    // MARK: - editing support

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let wordSetEntityProvider = wordSetEntityProvider, let wordSet = fetchedResultsController?.object(at: indexPath) else {
				DispatchQueue.main.async { [weak self] in
					guard let self = self else {
						return
					}
					let presenter = AlertPresenter(
						title: Constants.Alert.Title.trouble.rawValue,
						message: Constants.Alert.Message.unableToDelete,
						completionAction: nil)
					presenter.present(in: self.viewController)
				}
				return
            }
            wordSetEntityProvider.delete(wordSet: wordSet, shouldSave: true)
        }
    }
}
