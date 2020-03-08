//
//  SchemaTVC.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 07/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import UIKit

class SchemaTVC: UITableViewController {
    var content: Resume?
    var rowHeight:CGFloat = 64
    var rowCount:Int = 1
    var titles:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.titles = ResumeSchema.allCases.map { return $0.label()}
        self.rowCount = self.titles.count
        self.rowHeight = self.view.frame.height / CGFloat(self.rowCount)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.rowCount
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.titles[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let currentSchema:ResumeSchema = ResumeSchema.allCases[indexPath.row]
        
        let viewController:DrillTVC = DrillTVC()
        viewController.content = self.content
        viewController.type = titles[indexPath.row]
        viewController.title = titles[indexPath.row]
        viewController.node = Node(rawValue: currentSchema.rawValue)
        viewController.schema = currentSchema
        self.navigationController?.pushViewController(viewController as UIViewController, animated: true)
    }

}
