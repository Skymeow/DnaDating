//
//  CoredataStack.swift
//  Dndating
//
//  Created by Sky Xu on 12/10/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CoreDataStack {
    
    // The reason we instantiate an instance within the class itself so we don't instantiate the core data stack more than once due to the reason that we only want the contexts provided inside the class
    // This is making the Core Data Stack class a singleton
    static let instance = CoreDataStack()
    
    // By making the persistent cotainer a lazy variable then it is not called until needed , it delays the creation of the object until it is needed because the process is expensive
    
    // The purpose of this persistent container is hold the managed objects that are going to be send to the persistent store that we have declared a database where those objects are going to be stored
    private lazy var persistentContainer: NSPersistentContainer = {
        
        // Declaring the container which is the same name of the xcmodel this is just default for what the container is named
        let container = NSPersistentContainer(name: "Traits")
        
        // Now as we know the objects that are stored in the container are tunnled through the context the context is essentially where we tunnel the objects depending on what the user wants whether it is the view or background context
        
        // Then we load the stores for where we want to write the objects but by default the store is SQLite and the reason that we want to the use of the closure is due to the reason that it is going to be called back at a later time therefore we want to use a completion handler
        container.loadPersistentStores(completionHandler: { (completionHandler, error) in
            if let error = error as NSError? {
                // If there is an error then print me a description of the error
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        
        
        return container
    }()
    
    // The reason that we make this view context variable lazy is due to the reason that the process is expensive to call therefore only if the user explicitly calls for it then we let them access
    lazy var viewContext: NSManagedObjectContext = {
        
        // This is basically saying that we are going to access the container through the view context
        // It makes sense why when we access the view context that we use it for the display becuase the view context is performed on the main queue
        
        // The reason that in the private context variable that we set that store coordinators equal to the persistent containers persistent store coordinator is only becuase the view context does it for us
        let viewContext = persistentContainer.viewContext
        return viewContext
    }()
    
    lazy var privateContext: NSManagedObjectContext = {
        // To create the private context is a little bit different and the first step to making the background context is declaring which queue it is on therefore it will be on the private queue and the tasks that are performed on this background context are performed concurrently
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return privateContext
    }()
    
    func saveTo(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                print("There were changes made to the managed object and they have been saved")
                try context.save()
            }
            catch {
                let error = error as NSError?
                print("Fatal error there was trouble saving the changes: \(error), \(error?.localizedDescription)")
            }
        }
    }
    
    
}
