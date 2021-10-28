//
//  Repository.swift
//  Todoey
//
//  Created by Thiago Antonio Ramalho on 27/10/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit

class Repository {
        
    
    private lazy var path: URL? = {
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if var safeUrl = url.first {
            safeUrl.appendPathComponent("Items.pList")
            return safeUrl
        }
        
        return nil
    }()
  
    func put<T: Encodable>(data: T) {
        let encoder = PropertyListEncoder()
        
        do {
            if let url = path {
                let encodedData = try encoder.encode(data)
                try encodedData.write(to: url)
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
}
