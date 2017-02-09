//
//  Network.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import Overcoat
import AFNetworkActivityLogger
import ReactiveSwift
import OvercoatCoreData

let producersEndpoint = "producers"
let baseurl:String = "https://fd-v5-api-release.herokuapp.com/2"

class Network : OVCManagedHTTPSessionManager {

    static let shared : Network = {
        let instance = Network()
        return instance
    }()
    
    init() {
        
        // Set up session manager with managed object context and base URL
        let context = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
        super.init(baseURL: URL(string: baseurl), managedObjectContext: context, sessionConfiguration: nil)
        
        //AFNetworkActivityLogger.shared().startLogging()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /**
     Converts a network request into a signal
     
     - Parameter path: The resource path to access.
     - Parameter parameters: The parameters of the request
     
     - Returns: A new string with `str` repeated `times` times.
     */
    func networkRequestSignal<T>(path:String, parameters:[String:Any]?) -> SignalProducer<T,NSError> {
        
        // Create signal
        return SignalProducer<T,NSError> {
            sink, disposable in
            
            // Make request
            self.get(path, parameters: parameters) {
                (response:OVCResponse<AnyObject>?, error:Error?) in
                
                // Cast response and send to observer
                if let response = response?.result as? T {
                    sink.send(value: response)
                }
                
                // Send error if applicable
                if let error = error as? NSError {
                    sink.send(error: error)
                    // TODO: Handle Network Error
                }
            }
            
            return
        }
    }
    
    override class func modelClassesByResourcePath() -> [String : Any] {
        return [producersEndpoint : Producer.self]
    }
    
    override class func responseClassesByResourcePath() -> [String : Any] {
        return [producersEndpoint : ObjectResponseHandler.self]
    }
    
}

class ObjectResponseHandler: OVCResponse<AnyObject> {
    
    // Parse wraps JSON results in the "response" namespace.
    override class func resultKeyPath(forJSONDictionary JSONDictionary: [AnyHashable: Any]) -> String? {
        return "response"
    }
    
}
