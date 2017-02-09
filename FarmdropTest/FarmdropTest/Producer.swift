//
//  FObject.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import Mantle
import MTLManagedObjectAdapter

class Producer: MTLModel, MTLJSONSerializing, MTLManagedObjectSerializing {
    
    var identifier:NSNumber?
    var name:String?
    var images:[Image]?
    var shortDescription:String?
    var longDescription:String?
    var location:String?
    var viaWholesaler:NSNumber?
    var wholesalerName:String?

    class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "identifier"        : "id",
            "name"              : "name",
            "images"            : "images",
            "shortDescription"  : "short_description",
            "longDescription"   : "description",
            "location"          : "location",
            "viaWholesaler"     : "via_wholesaler",
            "wholesalerName"    : "wholesaler_name"
        ]
    }
    
    class func imagesJSONTransformer() -> ValueTransformer {
        return MTLJSONAdapter.arrayTransformer(withModelClass: Image.self)
    }
    
    static func managedObjectEntityName() -> String! {
        return "Producer"
    }
    
    static func propertyKeysForManagedObjectUniquing() -> Set<AnyHashable>! {
        return ["identifier"]
    }
    
    static func managedObjectKeysByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "identifier" : "identifier",
            "name"       : "name"
        ]
    }
    
}

