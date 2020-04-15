//
//  DetailViewController.swift
//  The Hat Game
//
//  Created by Arthur Duver on 06/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private lazy var wordSetEntityProvider: WordSetEntityProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let provider = WordSetEntityProvider(with: appDelegate.coreDataStack.persistentContainer,
                                   fetchedResultsControllerDelegate: self)
        return provider
    }()

    var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
    
    private var diffableDataSource: UITableViewDiffableDataSource<Section, String>?

    var wordSet: WordSetEntity!

    @IBAction private func wordSetNameEdited(_ sender: UITextField) {
        wordSetEntityProvider.changeName(wordSet: wordSet, newName: sender.text ?? "")
    }
    @IBOutlet private weak var detailTableView: UITableView!
    @IBOutlet private weak var wordSetNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewHeader()
        setupTableViewCore()
    }
    
    func updateSnapshot() {
        guard let words = wordSet.words else {
            return
        }
        
        print("il y a tant de mots : \(words.count)");
        var wordsData = [String]()
        for word in words {
            if let word = word as? WordEntity {
                if let data = word.data {
                    wordsData.append(data)
                    print(data)
                }
            }
        }
        snapshot.appendItems(wordsData)
        diffableDataSource?.apply(self.snapshot)
    }
    
    func setupTableViewCore() {
        diffableDataSource = UITableViewDiffableDataSource<Section, String>(tableView: detailTableView) { (tableView, indexPath, word) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
            cell.textLabel?.text = word
            return cell
        }
        snapshot.appendSections([.main])
        updateSnapshot()
    }
    
    func setupTableViewHeader() {
        wordSetNameTextField.text = wordSet.name
    }

}

// MARK: - Table View Delegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Fetched Result Controller Delegate

extension DetailViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}
