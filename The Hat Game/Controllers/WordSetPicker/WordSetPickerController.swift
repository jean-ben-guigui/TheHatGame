//
//  WordSetPickerController.swift
//  The Hat Game
//
//  Created by Arthur Duver on 26/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WordSetPickerController: UIViewController {
    enum Section {
        case main
    }

    private lazy var wordSetEntityProvider: WordSetEntityProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let provider = WordSetEntityProvider(with: appDelegate.coreDataStack.persistentContainer,
                                   fetchedResultsControllerDelegate: self)
        return provider
    }()
    
    private var fetchedResultsController: NSFetchedResultsController<WordSetEntity>?
    
    var snapshot = NSDiffableDataSourceSnapshot<WordSetTableViewSection, WordSetEntity>()
    
    private var diffableDataSource: WordSetUITableViewDiffableDataSource?
    
    var hatGame: HatGame!
    
    @IBOutlet private weak var wordSetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        setupFetchedResultController()
        setupTableView()
    }   
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        // Takes care of toggling the button's title.
        super.setEditing(!isEditing, animated: true)

        // Toggle table view editing.
        wordSetTableView.setEditing(!wordSetTableView.isEditing, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = wordSetTableView.indexPathForSelectedRow {
                let wordSetEntity = fetchedResultsController?.object(at: indexPath)
                if let detailViewController = segue.destination as? DetailViewController {
                    detailViewController.wordSet = wordSetEntity
                }
                wordSetTableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if segue.identifier == "chooseWorSetSegue" {
            if let indexPath = wordSetTableView.indexPathForSelectedRow {
                let wordSetEntity = fetchedResultsController?.object(at: indexPath) ?? WordSetEntity()
                hatGame.setWordSet(wordSet: WordSet(wordSetEntity: wordSetEntity))
                if let whosTurnViewController = segue.destination as? WhosTurnViewController {
                   whosTurnViewController.hatGame = hatGame
                }
            }
        }
    }
    
    private func setupTableView() {
        guard let fetchedResultsController = fetchedResultsController else {
            return
        }
        diffableDataSource = WordSetUITableViewDiffableDataSource(tableView: wordSetTableView) { (tableView, indexPath, wordSet) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "wordSetCell", for: indexPath)
            cell.textLabel?.text = wordSet.name
            return cell
        }
        
        diffableDataSource?.wordSetEntityProvider = wordSetEntityProvider
        diffableDataSource?.fetchedResultsController = fetchedResultsController
        
        updateSnapshot()
    }
    
    func setupFetchedResultController() {
        fetchedResultsController = wordSetEntityProvider.fetchedResultsController
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Failed to fetch results from the database.")
        }
    }
    
    func updateSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<WordSetTableViewSection, WordSetEntity>()
        snapshot.appendSections([.main])
        snapshot.appendItems(fetchedResultsController?.fetchedObjects ?? [])
        diffableDataSource?.apply(self.snapshot)
    }
}

// MARK: - Fetched Result Controller Delegate

extension WordSetPickerController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        switch type {
        case .insert:
            updateSnapshot()
        case .delete:
            if let identifierToDelete = self.diffableDataSource?.itemIdentifier(for: indexPath) {
              snapshot.deleteItems([identifierToDelete])
              diffableDataSource?.apply(snapshot)
            }
        case .update:
            updateSnapshot()
        case .move:
            updateSnapshot()
        @unknown default:
            updateSnapshot()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        wordSetTableView.endUpdates();
    }
}

// MARK: - Table View Delegate

extension WordSetPickerController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chooseWorSetSegue", sender: self)
    }
}
