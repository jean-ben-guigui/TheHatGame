//
//  CoreDataStack.swift
//  The Hat Game
//
//  Created by Arthur Duver on 25/03/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//
// A class to set up the Core Data stack
//

import Foundation
import CoreData

class CoreDataStack {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "The_Hat_Game")
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("###\(#function): Failed to load persistent stores:\(error)")
        })
        return container
    }()
    
    // MARK: - Core Data Saving support

   func saveContext () {
       let context = persistentContainer.viewContext
       if context.hasChanges {
           do {
               try context.save()
           } catch {
               // Replace this implementation with code to handle the error appropriately.
               // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
   }
}
