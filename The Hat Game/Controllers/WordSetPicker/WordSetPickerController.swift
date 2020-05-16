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
		diffableDataSource = WordSetUITableViewDiffableDataSource(tableView: wordSetTableView, viewController: self) { (tableView, indexPath, wordSet) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "wordSetCell", for: indexPath)
            cell.textLabel?.text = wordSet.name
            return cell
        }
        
//        diffableDataSource?.wordSetEntityProvider = wordSetEntityProvider
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
        self.snapshot = NSDiffableDataSourceSnapshot<WordSetTableViewSection, WordSetEntity>()
        self.snapshot.appendSections([.main])
        self.snapshot.appendItems(fetchedResultsController?.fetchedObjects ?? [])
		DispatchQueue.main.async() { [weak self] in
			guard let self = self else {
				return
			}
			self.diffableDataSource?.apply(self.snapshot, animatingDifferences: true)
		}
    }
}

// MARK: - Fetched Result Controller Delegate

extension WordSetPickerController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
    // There is still problems with this implementation. I tried to implement this so that I don't need to request everything from the data base each time. Without success though.
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            if let newWordSet = anObject as? WordSetEntity {
//                snapshot.appendItems([newWordSet])
//                diffableDataSource?.apply(snapshot)
//            }
//            else {
//                updateSnapshot()
//            }
//        case .delete:
//            guard let indexPath = indexPath else {
//                return
//            }
//            if let identifierToDelete = self.diffableDataSource?.itemIdentifier(for: indexPath) {
//              snapshot.deleteItems([identifierToDelete])
//              diffableDataSource?.apply(snapshot)
//            }
//        case .update:
//            guard let indexPath = indexPath, let newWordSet = anObject as? WordSetEntity, let identifierToDelete = self.diffableDataSource?.itemIdentifier(for: indexPath) else {
//               return updateSnapshot()
//            }
//            snapshot.deleteItems([identifierToDelete])
//            diffableDataSource?.apply(snapshot)
//
//            snapshot.appendItems([newWordSet])
//            diffableDataSource?.apply(snapshot)
//        case .move:
//            updateSnapshot()
//            print("silent warning, you should never be able to move something in wordSetEntity since it is already sorted by name.")
//        @unknown default:
//            updateSnapshot()
//            print("silent warning, unknow default from a switch")
//        }
//    }
}

// MARK: - Table View Delegate

extension WordSetPickerController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditing {
            performSegue(withIdentifier: "detailSegue", sender: self)
        } else {
            performSegue(withIdentifier: "chooseWorSetSegue", sender: self)
        }
    }
}
