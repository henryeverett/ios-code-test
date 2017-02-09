//
//  Network+Producers.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import Overcoat
import ReactiveSwift

extension Network {
    
    /**
     Makes an HTTP request to get producer list from API and returns a signal.
     
     - Parameter page: The page to request.
     - Parameter limit: The number of results to return on each page.
     
     - Returns: A signal producer which will provide the results or an error.
     */
    func listProducers(page:Int, limit:Int = 20) -> SignalProducer<[Producer], NSError> {
        
        // Prepare parameters dictionary
        var params = [String:Any]()
        params["page"] = page
        params["per_page_limit"] = limit

        // Return network request
        return self.networkRequestSignal(path: producersEndpoint, parameters: params)
    }
    
}
