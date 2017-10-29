//
//  ViewController.swift
//  TableViewTouchDown
//
//  Created by Ammy Pandey on 25/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ExpandableHeaderViewDelegate {
    @IBOutlet weak var movieTable: UITableView!
    
    var sections = [Section(genere: "Fruits", movies: ["Apple","Banana","Orange"], expanded: false), Section(genere: "Vegetables", movies: ["Tomato","Potato","Onion"], expanded: false), Section(genere: "Packged Food", movies: ["Sauce","Noodle","Milk"], expanded: false)]
  
    var selectedIndexPathArray = [String]()
    var checked = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTable.allowsMultipleSelection = false
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        //Reload the row depend on the size of movies array
        
        movieTable.beginUpdates()
        for i in 0 ..< sections[section].movies.count {
            //reload rows
            movieTable.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        movieTable.endUpdates()
        
    }
    
}
//Mark- UITableView Delegate Methods.
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genere, section: section, delegate: self)
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRow = tableView.cellForRow(at: indexPath)!
        
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                checked = [false]
                let indexToDelete = selectedIndexPathArray.index(of: ((selectedRow.textLabel?.text)! as NSString) as String)
                selectedIndexPathArray.remove(at: indexToDelete!)
                print(selectedIndexPathArray)
            }else {
                cell.accessoryType = .checkmark
                checked = [true]
                selectedIndexPathArray.append(((selectedRow.textLabel?.text)! as NSString) as String)
                print(selectedIndexPathArray)
            }
        }
 
    }
}

//Mark: UITableView DataSource Methods.
extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text  = sections[indexPath.section].movies[indexPath.row]
        
        if selectedIndexPathArray.contains(self.sections[indexPath.section].movies[indexPath.row]) {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = cell.isSelected ? .checkmark: .none
            cell.selectionStyle = .none
            
        }
        
        return cell
    }
    
    
}
