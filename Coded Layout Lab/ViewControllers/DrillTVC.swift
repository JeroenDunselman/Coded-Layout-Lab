//
//  DrillTVC.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 07/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import UIKit

class DrillTVC: UITableViewController {
    var type:String = ""
    
    var content: Resume?, schema: ResumeSchema?, node: Node?
    var detailRow: Int = 0
    
    var keys:[String] = [], values:[Any] = []
    var rowHeight:CGFloat = 64, rowCount:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        prepareContent()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.rowHeight
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        
        // Configure the cell...
        if let text = self.values[indexPath.row] as? String {
            cell.textLabel?.text = text
        }
        cell.detailTextLabel?.text = self.keys[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController:DrillTVC = DrillTVC()
        viewController.content = self.content
        viewController.type = keys[indexPath.row]
        viewController.title = keys[indexPath.row]
        
        switch self.keys[indexPath.row] {
        case "location": viewController.node = Node.locationDetails
        case "profiles": viewController.node = Node.profiles
        case "info": viewController.node = Node.info
        default: break
        }
        
        //prepare for data as array
        guard viewController.node != nil else {
            guard let type = self.schema?.rawValue, let detailNode:Node = Node(rawValue: "\(type)Details") else  {
                return
            }
            
            viewController.detailRow = indexPath.row
            viewController.node = detailNode
            
            self.navigationController?.pushViewController(viewController as UIViewController, animated: true)
            return
        }
        
        self.navigationController?.pushViewController(viewController as UIViewController, animated: true)
    }
}

extension Array {
    func stringed() -> String {
        if let content = self as? [String] {
            let result = content.reduce([]) {ar, el in return ar + "\(el)" }
            return "\(result)"
        }
        return ""
    }
}

extension DrillTVC {
    
    func prepareContent() {
        
        guard let node = self.node else {
            return
        }
        
        switch node {
        case .basics:
            if let content = self.content {
                self.keys = BasicsSchema.allCases.map { return "\($0.rawValue)"}
                self.values = BasicsSchema.allCases.map { return $0.content(content)}
            }
        case .work:
            if let keys = (content?.work.map {return "\($0.startDate) - \($0.endDate)"}),
                let values = (content?.work.map {return "\($0.company)"}) {
                self.keys = keys
                self.values = values
            }
        case .volunteer:
            if let keys = (content?.volunteer.map {return "\($0.startDate) - \($0.endDate)"}),
                let values = (content?.volunteer.map {return "\($0.organization)"}) {
                self.keys = keys
                self.values = values
            }
        case .awards:
            if let keys = (content?.awards.map {return "\($0.date)"}),
                let values = (content?.awards.map {return "\($0.awarder)"}) {
                self.keys = keys
                self.values = values
            }
        case .education:
            if let keys = (content?.education.map {return "\($0.institution)"}),
                let values = (content?.education.map {return "\($0.startDate) - \($0.endDate)"}) {
                self.keys = keys
                self.values = values
            }
        case .interests:
            if let keys = (content?.interests.map {return $0.keywords.joined(separator:", ")  }),
                let values = (content?.interests.map {return "\($0.name)"}) {
                self.keys = keys
                self.values = values
            }
        case .languages:
            if let keys = (content?.languages.map {return "\($0.fluency)"}),
                let values = (content?.languages.map {return "\($0.language)"}) {
                self.keys = keys
                self.values = values
            }
        case .publications:
            if let keys = (content?.publications.map {return "\($0.name)"}),
                let values = (content?.publications.map {return "\($0.releaseDate)"}) {
                self.keys = keys
                self.values = values
            }
        case .references:
            if let keys = (content?.references.map {return "\($0.name)"}),
                let values = (content?.references.map {return "\($0.reference)"}) {
                self.keys = keys
                self.values = values
            }
        case .skills:
            if let keys = (content?.skills.map {return "\($0.name)"}),
                let values = (content?.skills.map {return "\($0.level)"}) {
                self.keys = keys
                self.values = values
            }
        case .workDetails:
            if let result = (content?.work[self.detailRow]) {
                self.keys = WorkSchema.allCases.map { return "\($0.rawValue)"}
                self.values = WorkSchema.allCases.map { return $0.content(result)}
            }
        case .volunteerDetails:
            if let result = (content?.volunteer[self.detailRow]) {
                self.keys = VolunteerSchema.allCases.map { return "\($0.rawValue)"}
                self.values = VolunteerSchema.allCases.map { return $0.content(result)}
            }
        case .educationDetails:
            if let result = (content?.education[self.detailRow]) {
                self.keys = EducationSchema.allCases.map { return "\($0.rawValue)"}
                self.values = EducationSchema.allCases.map { return $0.content(result)}
            }
        case .awardsDetails:
            if let result = (content?.awards[self.detailRow]) {
                self.keys = AwardsSchema.allCases.map { return "\($0.rawValue)"}
                self.values = AwardsSchema.allCases.map { return $0.content(result)}
            }
        case .publicationsDetails:
            if let result = (content?.publications[self.detailRow]) {
                self.keys = PublicationsSchema.allCases.map { return "\($0.rawValue)"}
                self.values = PublicationsSchema.allCases.map { return $0.content(result)}
            }
        case .skillsDetails:
            if let result = (content?.skills[self.detailRow]) {
                self.keys = SkillsSchema.allCases.map { return "\($0.rawValue)"}
                self.values = SkillsSchema.allCases.map { return $0.content(result)}
            }
        case .locationDetails:
            if let result = self.content {
                self.keys = LocationSchema.allCases.map { return "\($0.rawValue)"}
                self.values = LocationSchema.allCases.map { return "\($0.content(result))"}
            }
        case .profiles:
            if let keys = (self.content?.basics.profiles.map { return "\($0.network): \($0.username) "}) ,
                let values = (self.content?.basics.profiles.map  { return "\($0.url)"}) {
                self.keys = keys
                self.values = values
            }
        case .info:
            if let result = self.content {
                self.keys = (InfoSchema.allCases.map { return $0.rawValue})
                self.values = (InfoSchema.allCases.map { return "\($0.content(result)) "})
            }
        default:
            self.keys = []
            self.values = []
        }
        
        self.rowCount = self.keys.count
        self.rowHeight = self.view.frame.height / CGFloat(self.rowCount)
    }
}
