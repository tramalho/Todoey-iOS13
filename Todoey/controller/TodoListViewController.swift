//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {
    
    var selectedCategory: Category? = nil
    
    private var itens: Results<Item>?
    
    private lazy var storage: Storage = {
        return Storage()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItens()
    }

    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = itens?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itens?[indexPath.row] {
                        
            storage.updateSelected(item:item)
            
            tableView.reloadData()
            
            tableView.deselectRow(at: indexPath, animated: true)

        }
    }
                
    //MARK - Add Itens
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var finalText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            if let text = finalText.text {
                
                let item = Item()
                item.title = text
                item.dateCreated = Date()
                self.save(item: item)
            }
        }
        
        alert.addTextField { alertTextField in
            finalText = alertTextField
            finalText.placeholder = "Create New Item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func save(item: Item) {
        if let safeCategory = self.selectedCategory {
            self.storage.save(item: item, category: safeCategory)
            self.tableView.reloadData()
        }
    }
    
    private func loadItens(searchText: String? = nil) {
        
        guard let safeCategory = selectedCategory else { return }
        
        if let safeText = searchText {
            itens = storage.loadItensBy(text: safeText, category: safeCategory)
        } else {
            itens = storage.loadItens(category: safeCategory)
        }
        
        tableView.reloadData()
    }
    
    override func update(index: Int) {
        storage.delete(item: itens?[index])
    }
}

//MARK - SearchBar Delegate Methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        loadItens(searchText: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            loadItens()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            loadItens(searchText: searchText)
        }
    }
}
