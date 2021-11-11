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
    
    func loadItens(category: Category? = nil) -> [Item] {
        
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        if let categoryName = category?.name {
//            request.predicate = NSPredicate(format: "parentCategory.name MATCHES %@", categoryName)
//        }
//
//        return findByRequest(request: request)
        
        return []
    }
    
    func loadItensBy(text: String, category: Category?) -> [Item] {
        
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        var listOfPredicates:[NSPredicate] = [NSPredicate(format: "title CONTAINS[cd] %@", text)]
//
//        if let categoryName = category?.name {
//            listOfPredicates.append(NSPredicate(format: "parentCategory.name MATCHES %@", categoryName))
//        }
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: listOfPredicates)
//
//        request.predicate = compoundPredicate
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        return findByRequest(request: request)
        
        return []
    }
    
    func loadCategories() -> [Category] {
        // return findByRequest(request: Category.fetchRequest())
        return []
    }
    
//    private func findByRequest<T>(request: NSFetchRequest<T>) -> [T] {
//        var itens: [T] = []
//
//        do {
//            // itens = try context.fetch(request)
//        } catch  {
//            print(error.localizedDescription)
//        }
//
//        return itens
//}
}
