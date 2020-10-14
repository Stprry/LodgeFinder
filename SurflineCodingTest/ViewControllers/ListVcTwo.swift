//
//  ListVcTwo.swift
//  SurflineCodingTest
//
//  Created by Sam Perry on 14/10/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit

class ListVcTwo: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let testArray = ["dog","cat","horse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
    }
//MARK:-- TableView Set up
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel!.text = testArray[indexPath.row]
        return cell
    }
}
