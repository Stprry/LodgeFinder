//
//  ListViewController.swift
//  SurflineCodingTest
//
//  Created by Sam Perry on 12/10/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var listOfLodges = [LodgeDetails](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfLodges.count) Lodges Found"
            }
        }
    }
    var lat = "50.4164582"
    let long = "-5.100202299999978"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        search()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfLodges.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        let lodge = listOfLodges[indexPath.row]
        let rating: String = String(format: "%f", lodge.rating)
        let open: String = String(format: "%f", lodge.opening_hours as! CVarArg)
        cell.textLabel?.text = lodge.name
        cell.detailTextLabel?.text = "Rating \(rating) Opening hours \(open)"
        return cell
    }
    
    func search(){
        let lodgeRequest = LodgeRequest(lat: lat, long: long)
        lodgeRequest.getLodges{[weak self]result in
            switch result{
            case.failure(let error):
                print(error)
            case.success(let lodges):
                self?.listOfLodges = lodges
            }}
    }
    
}


