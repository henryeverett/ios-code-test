//
//  ProducerViewController.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Kingfisher

class ProducerViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var producerNameLabel: UILabel!
    @IBOutlet weak var producerLocationLabel: UILabel!
    @IBOutlet weak var producerDescriptionTextView: UITextView!
    
    var viewModel:ProducerViewModel
    
    init(producer:Producer) {
        viewModel = ProducerViewModel(producer: producer)
        super.init(nibName: nil, bundle: nil)
    
        // Prevent view from hiding under navigation bar
        self.edgesForExtendedLayout = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ProducerViewController should not be initialized using coder.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Bind labels to view model
        producerNameLabel.reactive.text <~ viewModel.name
        producerLocationLabel.reactive.text <~ viewModel.location
        producerDescriptionTextView.reactive.text <~ viewModel.description
        
        // Bind to image URL and update from cache
        viewModel.imageURL.producer.startWithValues({
            (value:String) in
            self.headerImage.kf.setImage(with: URL(string: value))
        })
    }

}
