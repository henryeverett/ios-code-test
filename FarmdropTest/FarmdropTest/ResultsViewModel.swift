//
//  ResultsViewModel.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import UIKit
import ReactiveSwift
import CoreData
import MTLManagedObjectAdapter

class ResultsViewModel : NSObject, UISearchResultsUpdating {
    
    var searchResults = MutableProperty([Producer]())
    
    // MARK: - UISearchResultsUpdating delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Get managed object context
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext else {
            return
        }
        
        // Create fetch request and apply predicate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: "Producer", in: context)
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "name contains[c] %@", searchController.searchBar.text ?? "")
        
        do {
           
            // Perform fetch request
            if let searchResults = try context.fetch(fetchRequest) as? [NSManagedObject] {
                
                // Convert NSManagedObject results into Producer Models
                var producers = [Producer]()
                for object in searchResults {
                    do {
                        if let producer = try MTLManagedObjectAdapter.model(of: Producer.self, from: object) as? Producer {
                            producers.append(producer)
                        }
                    }
                }
                
                // Replace results array with new results
                self.searchResults.value = producers
                
            }
            
        } catch {
            print("Search results error.")
        }
        
    }
}
