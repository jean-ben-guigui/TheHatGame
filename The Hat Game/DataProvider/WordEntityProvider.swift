//
//  WordEntityProvider.swift
//  The Hat Game
//
//  Created by Arthur Duver on 26/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import CoreData

class WordEntityProvider {
    private(set) var persistentContainer: NSPersistentContainer
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?
    
    init(with persistentContainer: NSPersistentContainer,
        fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?) {
       self.persistentContainer = persistentContainer
       self.fetchedResultsControllerDelegate = fetchedResultsControllerDelegate
    }
    
    func addWordEntity(data: String, context: NSManagedObjectContext, shouldSave: Bool = true, completionHandler: ((_ newWordEntity: WordEntity) -> Void)? = nil) {
        context.performAndWait {
            let word = WordEntity(context: context)
            word.data = data
            
            if shouldSave {
                context.save(with: .addWordEntity)
            }
            completionHandler?(word)
        }
    }
}
