//
//  ProducerListViewController.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import UIKit

class ProducerListViewController : UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    private let viewModel = ProducerListViewModel()
    
    private var searchController:UISearchController?
    private var resultsController:ResultsTableViewController?
    
    init() {
        super.init(style: .plain)
        
        // Observe for changes to data source
        viewModel.producers.signal.observe {
            event in
    
            // Reload data
            self.tableView.reloadData()
            
            // Remove infinite scroll
            self.tableView.finishInfiniteScroll()
        }
        
        // Create infinite scroll UI and load a new page if activated
        tableView.addInfiniteScroll {
            (tableView:UITableView) in
            
            self.viewModel.loadNextPage()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.definesPresentationContext = true
        self.title = "Farmdrop"
        
        // Prepare search results view controller
        resultsController = ResultsTableViewController(style: .plain)
        resultsController?.parentController = self
        
        // Set up search controller and apply results controller
        searchController = UISearchController(searchResultsController: resultsController)
        searchController?.dimsBackgroundDuringPresentation = true
        
        // Add search bar to view
        searchController?.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController?.searchBar
        
        // Register delegates
        searchController?.delegate = self
        searchController?.searchBar.delegate = self
        searchController?.searchResultsUpdater = resultsController?.viewModel
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Load first page when view appears
        viewModel.loadNextPage()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.producers.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:ProducerCell
        
        // Dequeue or create new cell from nib
        if let producerCell = tableView.dequeueReusableCell(withIdentifier: "ProducerCell") as? ProducerCell {
            cell = producerCell
        } else {
            let cellNib = Bundle.main.loadNibNamed("ProducerCell", owner: self, options: nil)
            cell = cellNib?[0] as? ProducerCell ?? ProducerCell()
        }
        
        // Get producer object for row
        let producer = viewModel.producers.value[indexPath.row]
        
        // Update cell labels
        cell.producerNameLabel.text = producer.name
        
        // If the short description is empty or not available, fall back to long description.
        if let shortDescription = producer.shortDescription, shortDescription.characters.count > 0 {
            cell.producerDescriptionLabel.text = producer.shortDescription
        } else {
            cell.producerDescriptionLabel.text = producer.longDescription
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Push producer view onto navigation stack
        let producerViewController = ProducerViewController(producer: viewModel.producers.value[indexPath.row])
        self.navigationController?.pushViewController(producerViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 161
    }
    
    
    
}
