//
//  ProducerViewModel.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import ReactiveSwift

class ProducerViewModel {
    
    let name : MutableProperty<String>
    let location : MutableProperty<String>
    let description : MutableProperty<String>
    let imageURL : MutableProperty<String>
    
    init(producer:Producer) {
        
        // Update view model properties from model
        name = MutableProperty(producer.name ?? "")
        description = MutableProperty(producer.longDescription ?? producer.shortDescription ?? "")
        location = MutableProperty(producer.location ?? "")
        imageURL = MutableProperty(producer.images?.first?.path ?? "")
    }
    
}
