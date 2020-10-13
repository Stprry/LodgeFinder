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

    var lat = "50.4164582"
    let long = "-5.100202299999978"
    var listOfLodges = [LodgeDetail](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfLodges.count) lodges found"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listOfLodges.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)
        let lodge = listOfLodges[indexPath.row]
        let rating: String = String(lodge.rating!)//careful
        cell.textLabel?.text = rating
        return cell
    }
}
extension ListViewController{
    func loadData(){
        let lodgeRequest = LodgeRequest(lat: "50.4164582", long: "-5.100202299999978")
        lodgeRequest.getLodges{[weak self] result in
                    switch result{
                    case.failure(let error):
                        print(error)
                    case.success(let lodges):
                        self?.listOfLodges = lodges
                    }
            }
    }
}
