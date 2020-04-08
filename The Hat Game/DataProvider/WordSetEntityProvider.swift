//
//  WordSetEntityProvider.swift
//  The Hat Game
//
//  Created by Arthur Duver on 25/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//
// A class to wrap everything related to fetching, creating, and deleting WordSetEntities.
//

import Foundation
import CoreData

class WordSetEntityProvider {
    private(set) var persistentContainer: NSPersistentContainer
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?
    
    /**
     Date formatter for recording the timestamp in the default post title.
    */
    private lazy var mediumDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.locale = Locale.current
        return formatter
       }()
    
    init(with persistentContainer: NSPersistentContainer,
        fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?) {
       self.persistentContainer = persistentContainer
       self.fetchedResultsControllerDelegate = fetchedResultsControllerDelegate
    }
    
    /**
     A fetched results controller for the WordSetEntity, sorted.
     */
    lazy var fetchedResultsController: NSFetchedResultsController<WordSetEntity> = {
        let fetchRequest: NSFetchRequest<WordSetEntity> = WordSetEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: Schema.WordSetEntity.name.rawValue, ascending: false)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: persistentContainer.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = fetchedResultsControllerDelegate
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("###\(#function): Failed to performFetch: \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()
    
    func addWordSet(in context: NSManagedObjectContext, shouldSave: Bool = true, completionHandler: ((_ newWordEntity: WordSetEntity) -> Void)? = nil) {
        let wordSetEntity = WordSetEntity(context: context)
        let now = Date()
        wordSetEntity.name = mediumDateFormatter.string(from: now)
        
        if shouldSave {
            context.save(with: .addWordSetEntity)
        }
        completionHandler?(wordSetEntity)
    }
    
    func addWord(in context: NSManagedObjectContext, wordEntity: WordEntity, wordSetEntity: WordSetEntity, shouldSave: Bool = true, completionHandler: ((_ updatedWordEntity: WordSetEntity) -> Void)? = nil) {
        wordSetEntity.addToWords(wordEntity)
        if shouldSave {
            context.save(with: .addWordToWordSetEntity)
        }
        completionHandler?(wordSetEntity)
    }
    
    func areWordSetsNil() -> Bool {
        let fetchRequest: NSFetchRequest<WordSetEntity> = WordSetEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        let managedContext = persistentContainer.viewContext
        do {
            let peopleCount = try managedContext.count(for: fetchRequest)
            return peopleCount < 1
        } catch {
            return true
        }
        
//        let test = try? managedContext.fetch(fetchRequest)
    }
}
