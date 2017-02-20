//
//  AppDelegate.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var managedObjectContext:NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last)
        
        // Initialize core data store
        createCoreDataStack()
        
        // Set up initial view controller and pass into containing navigation controller.
        let producerListViewController = ProducerListViewController()
        let mainNavigationController = UINavigationController(rootViewController: producerListViewController)
        mainNavigationController.navigationBar.isTranslucent = false

        // Set up window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainNavigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    /**
     Set up the core data stack and its persistent store.
    */
    private func createCoreDataStack() {
        
        // Find URL for data model in bundle
        guard let modelURL = Bundle.main.url(forResource: "FarmdropModel", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        // Create NSManagedObjectModel
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing model")
        }
        
        // Prepare context and give it a coordinator with model
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            // Get user documents directory URL
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docURL = urls[urls.endIndex-1]
            
            // Create persistent store
            let storeURL = docURL.appendingPathComponent("FarmdropModel.sqlite")
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            } catch {
                fatalError("Error creating SQLite store")
            }
        }
        
        // Store context for later use
        managedObjectContext = context
        
    }
}

