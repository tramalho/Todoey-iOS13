//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Thiago Antonio Ramalho on 03/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryTableViewController: UITableViewController {

    private var categories: Results<Category>?
    
    private lazy var storage: Storage = {
        return Storage()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        categories = storage.loadCategories()
    }


    // MARK: - Data Manipulation Mehods
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        var finalText = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            if let text = finalText.text {
                
                let category = Category()
                category.name = text
                self.save(category: category)
            }
        }
        
        alert.addTextField { alertTextField in
            finalText = alertTextField
            finalText.placeholder = "Create New Category"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func save(category: Category) {
        self.storage.save(category: category)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        if let safeCell = cell as? SwipeTableViewCell {
            safeCell.delegate = self
        }
        
        let item = categories?[indexPath.row]
        cell.textLabel?.text = item?.name
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow, let vc = segue.destination as? TodoListViewController {
            vc.selectedCategory = categories?[indexPath.row]
        }
    }
}

//MARK: - SwipeCellKit delegate

extension CategoryTableViewController: SwipeTableViewCellDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.storage.delete(category: self.categories?[indexPath.row])
        }
        
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}
