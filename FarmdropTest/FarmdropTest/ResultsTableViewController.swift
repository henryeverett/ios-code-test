//
//  ResultsTableViewController.swift
//  FarmdropTest
//
//  Created by Henry Everett on 08/02/2017.
//  Copyright © 2017 Henry Everett. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    let viewModel = ResultsViewModel()
    var parentController:ProducerListViewController? // Reference to main list view for navigation controller access
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        // Start observing data source and reload tableView on update
        viewModel.searchResults.signal.observe {
            event in
            self.tableView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Create or dequeue cell
        var cell:UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "SearchCell")
        }
        
        // Apply name to cell title label
        cell.textLabel?.text = viewModel.searchResults.value[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Push producer view onto navigation stack
        let producerViewController = ProducerViewController(producer: viewModel.searchResults.value[indexPath.row])
        self.parentController?.navigationController?.pushViewController(producerViewController, animated: true)
    }
    

}
