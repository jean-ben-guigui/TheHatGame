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
    
    // MARK: reordering support
    
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        guard let sourceIdentifier = itemIdentifier(for: sourceIndexPath) else { return }
//        guard sourceIndexPath != destinationIndexPath else { return }
//        let destinationIdentifier = itemIdentifier(for: destinationIndexPath)
//
//        var snapshot = self.snapshot()
//
//        if let destinationIdentifier = destinationIdentifier {
//            if let sourceIndex = snapshot.indexOfItem(sourceIdentifier),
//               let destinationIndex = snapshot.indexOfItem(destinationIdentifier) {
//                let isAfter = destinationIndex > sourceIndex &&
//                    snapshot.sectionIdentifier(containingItem: sourceIdentifier) ==
//                    snapshot.sectionIdentifier(containingItem: destinationIdentifier)
//                snapshot.deleteItems([sourceIdentifier])
//                if isAfter {
//                    snapshot.insertItems([sourceIdentifier], afterItem: destinationIdentifier)
//                } else {
//                    snapshot.insertItems([sourceIdentifier], beforeItem: destinationIdentifier)
//                }
//            }
//        } else {
//            let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
//            snapshot.deleteItems([sourceIdentifier])
//            snapshot.appendItems([sourceIdentifier], toSection: destinationSectionIdentifier)
//        }
//        apply(snapshot, animatingDifferences: false)
//    }
    
    // MARK: editing support

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let wordSetEntityProvider = wordSetEntityProvider, let wordSet = fetchedResultsController?.object(at: indexPath) else {
                //TODO displays error message
                    return
            }
            wordSetEntityProvider.delete(wordSet: wordSet, shouldSave: true)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
