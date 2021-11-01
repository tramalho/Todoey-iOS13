//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    private var itens: [Item] = []
    
    private lazy var storage: Storage = {
        return Storage()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itens = storage.load()
    }


    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itens[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itens[indexPath.row]
        
        item.done = !item.done
                
        save()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
                
    //MARK - Add Itens
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var finalText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            if let text = finalText.text {
                
                let item = Item(context: self.storage.context)
                item.title = text
                item.done = false
                
                self.itens.append(item)
                self.save()
            }
        }
        
        alert.addTextField { alertTextField in
            finalText = alertTextField
            finalText.placeholder = "Create New Item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func save() {
        self.storage.save()
        self.tableView.reloadData()
    }
}

//MARK - SearchBar Delegate Methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let safeText = searchBar.text {
            itens = storage.loadBy(text: safeText)
        } else {
            itens = storage.load()
        }
        
        tableView.reloadData()
    }
}
