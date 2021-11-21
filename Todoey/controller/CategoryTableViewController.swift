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
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {

    private var categories: Results<Category>?
    
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
                
                let category = Category()
                category.name = text
                category.background = UIColor.randomFlat().hexValue()
                
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
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let item = categories?[indexPath.row]
        
        let backgroundColor = UIColor(hexString: item?.background ?? "ffffffff")!
        
        cell.textLabel?.text = item?.name
        cell.textLabel?.textColor = ContrastColorOf(backgroundColor, returnFlat: true)
        cell.backgroundColor = backgroundColor
        
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
    
    override func update(index: Int) {
        self.storage.delete(category: self.categories?[index])
    }
}
