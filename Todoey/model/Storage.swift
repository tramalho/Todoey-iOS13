//
//  Repository.swift
//  Todoey
//
//  Created by Thiago Antonio Ramalho on 27/10/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift



class Storage {
        
    private lazy var realm: Realm? = {
        var realm:Realm? = nil
        do {
            realm = try Realm()
        } catch  {
            print(error.localizedDescription)
        }
        
        return realm
    }()
    
  
    func save(category: Category) {
        
        do {
            try realm?.write({ realm?.add(category) })
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func save(item: Item, category: Category) {
        
        do {
            try realm?.write({ category.items.append(item) })
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    func updateSelected(item: Item) {
        
        do {
            try realm?.write({
                item.done = !item.done
            })
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func loadItens(category: Category) -> Results<Item>? {
        return category.items.sorted(byKeyPath: "title", ascending: true)
    }
    
    func loadItensBy(text: String, category: Category) -> Results<Item>? {
        return category.items.sorted(byKeyPath: "title", ascending: true)
    }
    
    func loadCategories() -> Results<Category>? {
        return realm?.objects(Category.self)
    }
}
