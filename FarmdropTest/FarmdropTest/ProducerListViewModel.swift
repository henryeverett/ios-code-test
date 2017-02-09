//
//  ProducerListViewModel.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import ReactiveSwift

class ProducerListViewModel {
    
    var currentPage = 1
    
    var nextPageSignal:SignalProducer<[Producer],NSError>?
    var nextPageDisposable:Disposable?
    var producers = MutableProperty([Producer]())
    
    /**
     Loads the next page of resuts from the server.
     */
    func loadNextPage() {
        
        // Update next page signal with new current page number
        nextPageSignal = Network.shared.listProducers(page: currentPage)
        
        // Subscribe to and start the next page signal
        nextPageDisposable?.dispose()
        nextPageDisposable = nextPageSignal?.start({
            (event:Event<[Producer], NSError>) in
            
            // TODO: Handle error
            print("Retrieved \(event.value?.count ?? 0) objects from server.")
            
            // Process the objects if they are present
            if let newObjects = event.value, newObjects.count > 0 {
                
                // Add new objects to darta source array
                self.producers.value += newObjects
                
                // Increase page number
                self.currentPage += 1
                
            }
            
        })
    }
    
}
