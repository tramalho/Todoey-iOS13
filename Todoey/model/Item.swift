//
//  Item.swift
//  Todoey
//
//  Created by Thiago Antonio Ramalho on 24/10/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

class Item:Codable {
    var done: Bool = false
    private (set) var title: String = ""
    
    init(title: String, done: Bool = false) {
        self.title = title
        self.done = done
    }
}
