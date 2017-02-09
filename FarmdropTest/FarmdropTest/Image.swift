//
//  Image.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import Mantle
import MTLManagedObjectAdapter

class Image: MTLModel, MTLJSONSerializing {
    
    var path:String?
    var position:NSNumber?
    
    class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "path"          : "path",
            "position"      : "position"]
    }
}
