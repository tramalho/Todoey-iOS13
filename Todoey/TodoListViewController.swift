//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    private var itens = ["Find Mike", "Buy eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itens[indexPath.row]
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if var accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType {
            if accessoryType == UITableViewCell.AccessoryType.none {
                accessoryType = .checkmark
            } else {
                accessoryType = UITableViewCell.AccessoryType.none
            }
            
            tableView.cellForRow(at: indexPath)?.accessoryType = accessoryType
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

