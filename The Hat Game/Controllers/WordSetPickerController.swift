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
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, WordSetEntity>()
    
    private var diffableDataSource: UITableViewDiffableDataSource<Section, WordSetEntity>?
    
    @IBOutlet private weak var wordSetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        setupFetchedResultController()
        setupTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = wordSetTableView.indexPathForSelectedRow {
                let wordSet = fetchedResultsController?.object(at: indexPath)
                if let detailViewController = segue.destination as? DetailViewController {
                    detailViewController.wordSet = wordSet
                }
                wordSetTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    private func setupTableView() {
        diffableDataSource = UITableViewDiffableDataSource<Section, WordSetEntity>(tableView: wordSetTableView) { (tableView, indexPath, wordSet) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "wordSetCell", for: indexPath)
            cell.textLabel?.text = wordSet.name
            return cell
        }
        snapshot.appendSections([.main])
        updateSnapshot()
    }
    
    func setupFetchedResultController() {
        fetchedResultsController = wordSetEntityProvider.fetchedResultsController
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            // Failed to fetch results from the database. Handle errors appropriately in your app.
            fatalError()
        }
    }
    
    func updateSnapshot() {
        snapshot.appendItems(fetchedResultsController?.fetchedObjects ?? [])
        
        diffableDataSource?.apply(self.snapshot)
    }
}

// MARK: - Fetched Result Controller Delegate

extension WordSetPickerController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}

// MARK: - Table View Delegate

extension WordSetPickerController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "detailSegue", sender: self)
  }
}
