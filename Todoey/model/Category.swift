//
//  Category.swift
//  Todoey
//
//  Created by Thiago Antonio Ramalho on 11/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var background = ""
    let items = List<Item>()
}
