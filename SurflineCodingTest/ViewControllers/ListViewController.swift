//
//  ListViewController.swift
//  SurflineCodingTest
//
//  Created by Sam Perry on 12/10/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//
import Foundation
import UIKit
class ListViewController: UITableViewController{
//MARK:-- Var / Let Declarations
    var passedLat: String = ""
    var passedLong: String = ""
    var name = ""
    var open = ""
    var rate = ""
    
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
        loadData()
    }
    
//MARK:-- Setting up Table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listOfLodges.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) // setting up cell
        let lodge = listOfLodges[indexPath.section]
        print(lodge.name as Any)// print for debugging
        
        if let rating: String = String(lodge.rating!) {
            rate = rating
        }
        
        if (lodge.opening_hours?.open_now) != nil {
                open = "open"
        }else{
            open = "shut"
        }
        
        if let name = lodge.name {
            let star = "⭐️"
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.text = """
                \(name).
                \(star) \(rate).
                is now \(open).
                """
        }
        return cell
    }
}
//MARK:-- Functions called on did load
extension ListViewController{
    func loadData() {
        print("Passed Data print: Lat: \(passedLat), Long: \(passedLong)")
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
}

