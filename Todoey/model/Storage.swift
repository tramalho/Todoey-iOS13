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
        var itens: [Item] = []
        
        do {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            itens = try context.fetch(request)
        } catch  {
            print(error.localizedDescription)
        }

        return itens
    }
}
