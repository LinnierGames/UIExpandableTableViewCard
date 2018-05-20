//
//  ViewController.swift
//  UIExpandableTableViewCard
//
//  Created by linniergames on 05/19/2018.
//  Copyright (c) 2018 linniergames. All rights reserved.
//

import UIKit
import UIExpandableTableViewCard

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listOfTaps = [String]()
    
    @IBOutlet weak var tableView: UIExpandableTableViewCard!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "cell"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listOfTaps.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.updateTableViewHeight()
    }
    
    @IBAction func pressAddARow(_ sender: Any) {
        listOfTaps.append("tap")
        tableView.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.updateTableViewHeight()
    }
}


