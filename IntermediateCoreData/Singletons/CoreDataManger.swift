//
//  CoreDataManger.swift
//  IntermediateCoreData
//
//  Created by Jacobo Hernandez on 10/14/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import CoreData

struct CoreDataManager {
    // will live forever as long as your application is still alive, it's properties will too
    // never gets reclaimed in memory by OS
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        
        return container
    }()
}
