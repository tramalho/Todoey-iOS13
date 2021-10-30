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
    
//    func get<T: Codable>() -> [T]? {
//        let decoder = PropertyListDecoder()
//        var response: [T]? = nil
//        do {
//            if let data = try? Data(contentsOf: path!) {
//                response = try decoder.decode([T].self, from: data)
//            }
//        } catch  {
//            print(error.localizedDescription)
//        }
//
//        return response
//    }
}
