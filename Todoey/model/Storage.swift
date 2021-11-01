//
//  Repository.swift
//  Todoey
//
//  Created by Thiago Antonio Ramalho on 27/10/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class Storage {
        
    private (set) lazy var context: NSManagedObjectContext = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        return context
    }()
    
  
    func save() {
        
        do {
            try context.save()
            print("success save")
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func load() -> [Item] {
        return findByRequest(request: Item.fetchRequest())
    }
    
    func loadBy(text: String) -> [Item] {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        return findByRequest(request: request)
    }
    
    private func findByRequest(request: NSFetchRequest<Item>) -> [Item] {
        var itens: [Item] = []
        
        do {
            itens = try context.fetch(request)
        } catch  {
            print(error.localizedDescription)
        }
        
        return itens
    }
}
