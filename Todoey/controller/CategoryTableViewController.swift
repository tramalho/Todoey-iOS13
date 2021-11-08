//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Thiago Antonio Ramalho on 03/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    private var categories: [Category] = []
    
    private lazy var storage: Storage = {
        return Storage()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = storage.loadCategories()
    }


    // MARK: - Data Manipulation Mehods
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        var finalText = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            if let text = finalText.text {
                
                let category = Category(context: self.storage.context)
                category.name = text
                
                self.categories.append(category)
                self.save()
            }
        }
        
        alert.addTextField { alertTextField in
            finalText = alertTextField
            finalText.placeholder = "Create New Category"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func save() {
        self.storage.save()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories[indexPath.row]
        
        cell.textLabel?.text = item.name
                
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow, let vc = segue.destination as? TodoListViewController {
            vc.selectedCategory = categories[indexPath.row]
        }
    }
}
