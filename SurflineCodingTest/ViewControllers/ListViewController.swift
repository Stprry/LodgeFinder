//
//  ListViewController.swift
//  SurflineCodingTest
//
//  Created by Sam Perry on 12/10/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//
///var Testlat = "50.4164582"
///var Testlong = "-5.100202299999978"

import Foundation
import UIKit
protocol DataDelegate {
    func passLatLong(lat: String,long:String)
}

class ListViewController: UITableViewController,DataDelegate{
//MARK:-- Var / Let Declarations
    var passedLat = ""
    var passedLong = ""
    var name = ""
    
//MARK:-- Computed vars
    var listOfLodges = [LodgeDetail](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfLodges.count) lodges found"
                print("\(self.listOfLodges.count) lodges found")
                print(" ")
            }
        }
    }
//MARK: -- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        loadData()
    }
//MARK:-- Setting up Table view
    @objc func setDelegate(){
        let landing = LandingViewController()
        landing.delegate = self
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listOfLodges.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)
        let lodge = listOfLodges[indexPath.section]
        let rating: String = String(lodge.rating!)//careful force unwrapping something that might not be there could cause an error
        print(rating)
        print(lodge.name)
        
        if let name = lodge.name {
            cell.textLabel?.text = name
        }
        
      
        cell.detailTextLabel?.text = "Lodge Rating \(rating) Lodge Open now \(String(describing: lodge.opening_hours?.open_now))"
        
        return cell
    }
}
//MARK:-- Functions called on did load
extension ListViewController{
    func loadData(){
        let lodgeRequest = LodgeRequest(lat:passedLat, long:passedLong)
        lodgeRequest.getLodges{[weak self] result in
                    switch result{
                    case.failure(let error):
                        print(error)
                    case.success(let lodges):
                        self?.listOfLodges = lodges
                    }
            }
    }
    func passLatLong(lat: String, long: String) {
        passedLat = lat
        passedLong = long
    }
}

